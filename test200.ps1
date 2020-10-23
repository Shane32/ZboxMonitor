[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = "SilentlyContinue"
$ErrorActionPreference = "Continue"

"--- Testing $($Env:URL_TO_CHECK) ---"
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$response5 = Invoke-WebRequest -Uri $Env:URL_TO_CHECK -Method Get -UseBasicParsing
"--- Answer in $($stopwatch.ElapsedMilliseconds)ms ---"
$response5
"------------------------------------"
if (!$response5 -or !$response5.StatusCode -eq 200) {
    $BodyTemplate = @"
        {
            "channel": "$($Env:SLACK_CHANNEL_NAME)",
            "username": "Azure Uptime Bot",
            "text": "$($Env:URL_TO_CHECK) is currently offline; not returning 200 status code",
            "icon_emoji":":bangbang:"
        }
"@

    Invoke-RestMethod -uri $Env:SLACK_CHANNEL_URI -Method Post -body $BodyTemplate -ContentType 'application/json'

    exit 1
}
