#!/bin/bash

set -euxo pipefail

ci_build_dir=$SMALLTALK_CI_BUILD
package_dir="$PROJECT_NAME-$PLATFORM"
vm_dir=`cat $SMALLTALK_CI_VM | sed 's|\(.*\)/.*|\1|'`/pharo-vm

mkdir -p "$package_dir/image"
mkdir -p "$package_dir/pharo"

cp $ci_build_dir/TravisCI.image $package_dir/image/$PROJECT_NAME.image
cp $ci_build_dir/TravisCI.changes $package_dir/image/$PROJECT_NAME.changes
cp $ci_build_dir/*.sources $package_dir/image

cp -r $vm_dir/bin $package_dir/pharo/bin
cp -r $vm_dir/lib $package_dir/pharo/lib

cat << EOF > $package_dir/$PROJECT_NAME
#!/bin/bash
\`dirname "\$0"\`/pharo/bin/pharo \`dirname "\$0"\`/image/$PROJECT_NAME.image
EOF

chmod a+rx $package_dir/$PROJECT_NAME

"$vm_dir/bin/pharo" --headless $package_dir/image/$PROJECT_NAME.image eval --save "OPVersion currentWithRunId: $RUN_ID projectName: '$REPOSITORY_NAME'"

zip -qr $PROJECT_NAME-$PLATFORM-$VERSION.zip $package_dir
