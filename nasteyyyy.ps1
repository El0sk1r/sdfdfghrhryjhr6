$TempDir = "C:\temp"
$WbpvZipUrl = "http://www.nirsoft.net/toolsdownload/webbrowserpassview.zip"
$SevenZipUrl = "https://www.7-zip.org/a/7za920.zip"

if(!(Test-Path $TempDir)) {
  New-Item -ItemType Directory -Path $TempDir
}

Set-Location $TempDir

Invoke-WebRequest -Headers @{'Referer' = 'http://www.nirsoft.net/utils/web_browser_password.html'} -Uri $WbpvZipUrl -OutFile 'wbpv.zip'
Invoke-WebRequest -Uri $SevenZipUrl -OutFile '7z.zip'

$SevenZipDir = Join-Path $TempDir '7z'
if(!(Test-Path $SevenZipDir)) {
  Expand-Archive '7z.zip' -DestinationPath $TempDir
}

& '.\7z\7za.exe' e 'wbpv.zip'
