$ci_build_dir="$home\.smalltalkCI\_builds"

$REPOSITORY_NAME=$Env:REPOSITORY_NAME
$PROJECT_NAME=$Env:PROJECT_NAME
$PLATFORM=$Env:PLATFORM
$VERSION=$Env:VERSION
$RUN_ID=$Env:RUN_ID

$package_dir="$PROJECT_NAME-$PLATFORM"
$vm_file_content=Get-Content $ci_build_dir/vm | Out-String
$vm_dir=(($vm_file_content -replace '/[^/]*$','/pharo-vm') -replace '/c/','C:\') -replace '/','\'

mkdir $package_dir

cp $ci_build_dir/TravisCI.image $package_dir/$PROJECT_NAME.image
cp $ci_build_dir/TravisCI.changes $package_dir/$PROJECT_NAME.changes
cp $ci_build_dir/*.sources $package_dir

cp $vm_dir/*.dll $package_dir
cp $vm_dir/Pharo.exe $package_dir/$PROJECT_NAME.exe

& $vm_dir/PharoConsole.exe -headless $package_dir/$PROJECT_NAME.image eval --save "OPVersion currentWithRunId: $RUN_ID projectName: '$REPOSITORY_NAME'"

Compress-Archive -Path $package_dir -DestinationPath $PROJECT_NAME-$PLATFORM-$VERSION