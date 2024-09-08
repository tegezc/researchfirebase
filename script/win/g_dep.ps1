Write-Host "Starting Flutter clean, pub get, and build_runner process..."

# Menjalankan flutter clean
flutter clean
if ($LASTEXITCODE -ne 0) {
    Write-Host "Flutter clean failed!"
    exit $LASTEXITCODE
}
Write-Host "Flutter clean completed successfully."

# Menjalankan flutter pub get
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "Flutter pub get failed!"
    exit $LASTEXITCODE
}
Write-Host "Flutter pub get completed successfully."

# Menjalankan build_runner
dart run build_runner build --delete-conflicting-outputs
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build runner failed!"
    exit $LASTEXITCODE
}
Write-Host "Build runner completed successfully."
