[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = "SilentlyContinue"
$ErrorActionPreference = "Continue"
$QUERY_TO_CHECK = $Env:QUERY_TO_CHECK -replace "`r","" -replace "`n",""

"--- Testing GraphQL API: $($Env:URL_TO_CHECK) ---"
"--- Testing Query desc: $($Env:QUERY_DESC) ---"
"--- Testing Query: $($QUERY_TO_CHECK) ---"
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$response5 = Invoke-RestMethod -Uri $Env:URL_TO_CHECK -Method Post -Body $QUERY_TO_CHECK -ContentType 'application/json'
"--- Answer in $($stopwatch.ElapsedMilliseconds)ms ---"
$response5
"------------------------------------"
if (!$response5 -or $response5.errors) {
    $BodyTemplate = @"
        {
            "channel": "#software",
            "username": "Azure Uptime Bot",
            "text": "$($Env:URL_TO_CHECK) is currently offline retrieving $($Env:QUERY_DESC); not returning graphql query data",
            "icon_emoji":":bangbang:"
        }
"@

    Invoke-RestMethod -uri $Env:SLACK_CHANNEL_URI -Method Post -body $BodyTemplate -ContentType 'application/json'

    exit 1
}
