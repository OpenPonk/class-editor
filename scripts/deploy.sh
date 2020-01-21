#!/bin/bash

set -euxo pipefail

prepare_directory() {

	local platform=$1
	local package_dir=$2

	mkdir -p "$package_dir"

	cp $SMALLTALK_CI_IMAGE $package_dir/openponk-$PROJECT_NAME.image
	cp $SMALLTALK_CI_CHANGES $package_dir/openponk-$PROJECT_NAME.changes
	cp $SMALLTALK_CI_BUILD_BASE/*.sources $package_dir
	echo "$PHARO_VERSION_SIMPLE" > $package_dir/pharo.version
}

download_vm() {

	local platform=$1
	local vm_dir=$2
	local zip="$vm_dir/vm.zip"

	mkdir -p "$vm_dir"

	curl --location --compressed --output "$zip" "http://files.pharo.org/get-files/$PHARO_VERSION_SIMPLE/pharo${PHARO_BITS//32}-${platform}-stable.zip"
	unzip "$zip" -d "$vm_dir"
	rm "$zip"
}

upload() {	

	local platform=$1
	local package_dir_name=$2
	local working_dir="$package_dir_name-$PHARO_FULL_VERSION-build$TRAVIS_BUILD_NUMBER"
	local package_dir="$working_dir/$package_dir_name"
	local zip="$working_dir.zip"

	cd $working_dir
	zip -qr "$zip" "${package_dir_name}"

	set +x
		curl -k -v -u "${DEPLOY_KEY}" --upload-file $zip https://nexus.openponk.ccmi.fit.cvut.cz/repository/$repository/byplatform/"${PHARO_FULL_VERSION}"/"${platform}"/"${PROJECT_NAME}"/${zip}
		curl -k -v -u "${DEPLOY_KEY}" --upload-file $zip https://nexus.openponk.ccmi.fit.cvut.cz/repository/$repository/byversion/"${PROJECT_NAME}"/"$BUILD_NAME"/${zip}
	set -x
}

deploy_linux() {

	local platform="linux"

	local package_dir_name="openponk-$PROJECT_NAME-$platform"
	local working_dir="$package_dir_name-$PHARO_FULL_VERSION-build$TRAVIS_BUILD_NUMBER"
	local package_dir="$working_dir/$package_dir_name"
	local vm_dir="$package_dir"

	prepare_directory $platform $package_dir
	download_vm "$platform-threaded" $vm_dir

	rm $vm_dir/pharo
	cat << EOF > $vm_dir/openponk-$PROJECT_NAME
#!/bin/bash
./bin/pharo openponk-$PROJECT_NAME.image
EOF
	chmod a+rx $vm_dir/openponk-$PROJECT_NAME

	upload $platform "$package_dir_name"

}

deploy_windows() {

	local platform="win"

	local package_dir_name="openponk-$PROJECT_NAME-$platform"
	local working_dir="$package_dir_name-$PHARO_FULL_VERSION-build$TRAVIS_BUILD_NUMBER"
	local package_dir="$working_dir/$package_dir_name"
	local vm_dir="$package_dir"

	prepare_directory $platform $package_dir
	download_vm $platform $vm_dir
	
	mv $vm_dir/*haro.exe $vm_dir/openponk-$PROJECT_NAME.exe
	rm $vm_dir/*haroConsole.exe
	rm $vm_dir/*Zone.Identifier || true

	upload $platform "$package_dir_name"

}

deploy_image() {
	
	local platform="image"

	local package_dir_name="openponk-$PROJECT_NAME-$platform"
	local working_dir="$package_dir_name-$PHARO_FULL_VERSION-build$TRAVIS_BUILD_NUMBER"
	local package_dir="$working_dir/$package_dir_name"

	prepare_directory $platform $package_dir

	upload $platform "$package_dir_name"

}

main() {

	export PHARO_VERSION_SIMPLE="${PHARO_VERSION//.}"
	export PHARO_FULL_VERSION="pharo$PHARO_VERSION-${PHARO_BITS}b"

	deploy_image
	deploy_linux
	deploy_windows
}

export TRAVIS_BUILD_NUMBER=`printf "%04d\n" $TRAVIS_BUILD_NUMBER`

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
	export BUILD_NAME="build$TRAVIS_BUILD_NUMBER"
	export repository="builds"
	main
fi

if [[ -n "$TRAVIS_TAG" ]]; then
	export BUILD_NAME="$TRAVIS_TAG"
	export repository="releases"
	main
fi

