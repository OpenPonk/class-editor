#!/usr/bin/env bats

readonly ARTIFACT_DIR="openponk"

@test "master build has been deployed" {
	mkdir -p $ARTIFACT_DIR
	echo "image" > $ARTIFACT_DIR/openponk.image
	echo "changes" > $ARTIFACT_DIR/openponk.changes
	export CI_JOB_ID=0
	export CI_COMMIT_REF_NAME=master
	export ARTIFACT_DIR
	run ../deploy.sh
	echo $output
	[ "${lines[0]}" = "deploy test master-0 ok" ]
	[ $status -eq 0 ]
}

teardown() {
	rm -rf openponk
	rm -rf openponk-master-0
	rm -f openponk-image-master-0.zip
}
