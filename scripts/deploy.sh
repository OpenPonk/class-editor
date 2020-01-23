#!/bin/bash

set -euxo pipefail

prepare_directory() {

	local platform=$1
	local full_platform=$platform$PHARO_BITS_NAME
	local package_dir_name="openponk-$PROJECT_NAME-$full_platform"
	local working_dir="$package_dir_name-$BUILD_VERSION"
	local package_dir="$working_dir/$package_dir_name"

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
	local full_platform=$platform$PHARO_BITS_NAME
	local package_dir_name="openponk-$PROJECT_NAME-$full_platform"
	local working_dir="$package_dir_name-$BUILD_VERSION"
	local zip="$package_dir_name-latest.zip"

	cd $working_dir
	zip -qr "$zip" "${package_dir_name}"

	set +x
		echo "curl -v -T $zip -ujanbliznicenko:BINTRAY_KEY https://api.bintray.com/content/openponk/builds/packages/1/${PROJECT_NAME}/$BUILD_VERSION/${zip}?publish=1&override=1"
		curl -v -T $zip -ujanbliznicenko:"${BINTRAY_KEY}" https://api.bintray.com/content/openponk/builds/packages/1/"${PROJECT_NAME}"/"${BUILD_VERSION}"/"${zip}"?"publish=1&override=1"
	set -x
}

deploy_linux() {

	local platform="linux"

	local full_platform=$platform$PHARO_BITS_NAME
	local package_dir_name="openponk-$PROJECT_NAME-$full_platform"
	local working_dir="$package_dir_name-$BUILD_VERSION"
	local package_dir="$working_dir/$package_dir_name"
	local vm_dir="$package_dir"

	prepare_directory $platform
	download_vm "$platform-threaded" $vm_dir

	rm $vm_dir/pharo
	cat << EOF > $vm_dir/openponk-$PROJECT_NAME
#!/bin/bash
./bin/pharo openponk-$PROJECT_NAME.image
EOF
	chmod a+rx $vm_dir/openponk-$PROJECT_NAME

	upload $platform

}

deploy_windows() {

	local platform="win"

	local full_platform=$platform$PHARO_BITS_NAME
	local package_dir_name="openponk-$PROJECT_NAME-$full_platform"
	local working_dir="$package_dir_name-$BUILD_VERSION"
	local package_dir="$working_dir/$package_dir_name"
	local vm_dir="$package_dir"

	prepare_directory $platform
	download_vm $platform $vm_dir
	
	mv $vm_dir/*haro.exe $vm_dir/openponk-$PROJECT_NAME.exe
	rm $vm_dir/*haroConsole.exe
	rm $vm_dir/*Zone.Identifier || true

	upload $platform

}

deploy_image() {
	
	local platform="pharo$PHARO_VERSION-image"

	local full_platform=$platform$PHARO_BITS_NAME
	local package_dir_name="openponk-$PROJECT_NAME-$full_platform"
	local working_dir="$package_dir_name-$BUILD_VERSION"
	local package_dir="$working_dir/$package_dir_name"

	prepare_directory $platform

	upload $platform

}

main() {

	export PHARO_VERSION_SIMPLE="${PHARO_VERSION//.}"
	export PHARO_BITS_NAME="${PHARO_BITS}b"
	export PHARO_FULL_VERSION="pharo$PHARO_VERSION-$PHARO_BITS_NAME"

	deploy_image
	deploy_linux
	deploy_windows
}

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
	export BUILD_VERSION="latest"
	main
fi

if [[ -n "$TRAVIS_TAG" ]]; then
	export BUILD_VERSION="$TRAVIS_TAG"
	main
fi

