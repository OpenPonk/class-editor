#!/bin/bash

set -euxo pipefail

ci_build_dir=$SMALLTALK_CI_BUILD
package_dir="$PROJECT_NAME-$PLATFORM"
vm_dir=`cat $SMALLTALK_CI_VM | sed 's|\(.*\)/.*|\1|'`/pharo-vm

mkdir -p "$package_dir/image"

cp -r $vm_dir/Pharo.app/ $package_dir/Pharo.app

cp $ci_build_dir/TravisCI.image $package_dir/image/$PROJECT_NAME.image
cp $ci_build_dir/TravisCI.changes $package_dir/image/$PROJECT_NAME.changes
cp $ci_build_dir/*.sources $package_dir/image

cat << EOF > $package_dir/$PROJECT_NAME
#!/bin/bash
\`dirname "\$0"\`/Pharo.app/Contents/MacOS/Pharo \`dirname "\$0"\`/image/$PROJECT_NAME.image
EOF

chmod a+rx $package_dir/$PROJECT_NAME

cat << EOF > $package_dir/README.txt

-- Opening OpenPonk on macOS 10 and 11 --

Main issue of opening OpenPonk on macOS 10 is Gatekeeper protection against executables from unverified sources.
There are two options to overcome it. 
First option requires a little more clicking each time opening OpenPonk, but very simple first time setup, 
Second option requires much more steps first time opening (or after updating OP), but further opening becomes simple double click.

First option:
	First time opening (or after updating OP): 
		1) Double click Pharo.app
		-> "Pharo cannot be opened because the developer cannot be verified"
		2) Cancel
		3) Right click Pharo.app
		4) Open
		-> "macOS cannot verify the developer of Pharo"
		5) Open
		-> Window with file selection opened
		6) Find and select file $PROJECT_NAME.image in the image folder
		-> "Pharo would like to access files"...
		7) OK
		-> OpenPonk should open now. If there is a window asking to receive keystrokes, you may Deny it
	Opening:
		1) Double click Pharo.app
		-> Window with file selection opened
		2) Find and select file $PROJECT_NAME.image in the image folder

Second option:
	First time opening (or after updating OP):
		1) Right click the $PROJECT_NAME (Unix executable)
		2) Open
		-> "macOS cannot verify the developer of $PROJECT_NAME"
		3) Open
		-> "Pharo cannot be opened because the developer cannot be verified"
		4) Cancel
		5) Open macOS System Preferences...
		6) Security & Privacy
		7) Switch to General tab (if not already there)
		-> There should be text about "Pharo" or "Pharo.app" being blocked and Open Anyway button next to it.
		8) Click on Open Anyway button
		-> "macOS cannot verify the developer of Pharo"
		9) Open
		-> Window with file selection opened
		10) Cancel
		11) Double click $PROJECT_NAME (Unix executable)
		-> "Terminal would like to access files"... That, along with next step, might be skipped if the access is already granted.
		12) OK
		-> OpenPonk should open now. If there is a window asking to receive keystrokes, you may Deny it
	Opening:
		1) Double click $PROJECT_NAME (Unix executable)
EOF

$vm_dir/Pharo.app/Contents/MacOS/Pharo --headless $package_dir/image/$PROJECT_NAME.image eval --save "OPVersion currentWithRunId: $RUN_ID projectName: '$REPOSITORY_NAME'"

zip -qr $PROJECT_NAME-$PLATFORM-$VERSION.zip $package_dir
