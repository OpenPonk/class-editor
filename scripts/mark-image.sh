#!/bin/bash

set -eu

SMALLTALK_VM=${SMALLTALK_VM:-$(find $SMALLTALK_CI_VMS -name pharo -type f -executable | head -n 1)}
readonly IMAGE="$1"

run_script() {
	local script=$1
	"$SMALLTALK_VM" --nodisplay "$IMAGE" --no-default-preferences eval --save "$script"
}

close_pharo_help() {
	run_script "World submorphs select: [ :each | (each isKindOf: SystemWindow) and: [ each label = WelcomeHelp bookName ] ] thenDo: #delete."
}

main() {
	close_pharo_help
}

main
