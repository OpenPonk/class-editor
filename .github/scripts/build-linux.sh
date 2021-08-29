#!/bin/bash

set -euxo pipefail

ci_build_dir=$SMALLTALK_CI_BUILD
package_dir="$PROJECT_NAME-$PLATFORM"
vm_dir=`cat $SMALLTALK_CI_VM | sed 's|\(.*\)/.*|\1|'`/pharo-vm

mkdir -p "$package_dir"

cp $ci_build_dir/TravisCI.image $package_dir/$PROJECT_NAME.image
cp $ci_build_dir/TravisCI.changes $package_dir/$PROJECT_NAME.changes
cp $ci_build_dir/*.sources $package_dir

cp -r $vm_dir/bin $package_dir/bin
cp -r $vm_dir/lib $package_dir/lib
cat << EOF > $package_dir/$PROJECT_NAME
#!/bin/bash
./bin/pharo $PROJECT_NAME.image
EOF

chmod a+rx $package_dir/$PROJECT_NAME

"$vm_dir/bin/pharo" --headless $package_dir/$PROJECT_NAME.image eval --save "OPVersion currentWithRunId: $RUN_ID projectName: '$REPOSITORY_NAME'"

zip -qr $PROJECT_NAME-$PLATFORM-$VERSION.zip $package_dir
