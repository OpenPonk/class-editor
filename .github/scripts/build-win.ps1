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
mkdir $package_dir/image
mkdir $package_dir/Pharo

cp $ci_build_dir/TravisCI.image $package_dir/image/$PROJECT_NAME.image
cp $ci_build_dir/TravisCI.changes $package_dir/image/$PROJECT_NAME.changes
cp $ci_build_dir/*.sources $package_dir/image

cp $vm_dir/*.dll $package_dir/Pharo
cp $vm_dir/Pharo.exe $package_dir/Pharo
cp $vm_dir/PharoConsole.exe $package_dir/Pharo

"@echo off
set DIRNAME_S=%~dp0
echo %DIRNAME_S% | findstr `"cvut.cz`" > nul
if %ERRORLEVEL% EQU 0 (
  for /F `"tokens=3,* delims=\`" %%a in (`"%DIRNAME_S%`") do (
    set DIRNAME_S=X:\%%b
  )
)

echo Opening: %DIRNAME_S%Pharo\Pharo.exe %DIRNAME_S%image\$PROJECT_NAME.image
start %DIRNAME_S%Pharo\Pharo.exe %DIRNAME_S%image\$PROJECT_NAME.image" | set-content "$package_dir/$PROJECT_NAME.bat"

"Open using $PROJECT_NAME.bat.

OpenPonk does not work when executed from network drives (like \\example.com\home), unless accessed via mapped letter drive (like X:\). There is a hardcoded fix for fit.cvut.cz student home directories." | set-content "$package_dir/README.txt"

& $vm_dir/PharoConsole.exe -headless $package_dir/image/$PROJECT_NAME.image eval --save "OPVersion currentWithRunId: $RUN_ID projectName: '$REPOSITORY_NAME'"

Compress-Archive -Path $package_dir -DestinationPath "$PROJECT_NAME-$PLATFORM-$VERSION.zip"
