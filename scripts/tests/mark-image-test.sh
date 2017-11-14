#!/usr/bin/env bats

readonly SMALLTALK_VM=pharo-vm/pharo
export SMALLTALK_VM
readonly SMALLTALK_IMAGE=openponk/openponk.image

pharo-eval() {
	local script="$1"
	$SMALLTALK_VM --nodisplay $SMALLTALK_IMAGE --no-default-preferences eval "$script"
}

@test "logo has been enabled" {
	pharo-eval "PolymorphSystemSettings showDesktopLogo: false"
	../mark-image.sh $SMALLTALK_IMAGE
	run pharo-eval "PolymorphSystemSettings showDesktopLogo"
	[ "$output" = "true" ]
}

@test "Pharo help is closed" {
	../mark-image.sh $SMALLTALK_IMAGE
	pharo-eval "World submorphs detect: [ :each | (each isKindOf: SystemWindow) and: [ each label = WelcomeHelp bookName ] ] ifFound: [ :each | self error: 'WelcomeHelp still opened' ]"

}

setup() {
	if [ ! -e openponk/openponk.image ]; then
		local build="openponk-image-100.zip"
		wget "https://openponk.ccmi.fit.cvut.cz/builds/core/image/${build}"
		unzip "$build"
		mv "$build" openponk
	fi
	[ -e openponk/openponk.image ]
}
