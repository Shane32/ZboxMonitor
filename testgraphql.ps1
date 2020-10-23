[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = "SilentlyContinue"
$ErrorActionPreference = "Continue"

"--- Testing GraphQL API: $($Env:URL_TO_CHECK) ---"
"--- Testing Query: $($Env:QUERY_TO_CHECK) ---"
$response5 = Invoke-RestMethod -Uri $Env:URL_TO_CHECK -Method Post -Body $Env:QUERY_TO_CHECK -ContentType 'application/json'
$response5
"------------------------------------"
if (!$response5 -or $response5.errors) {
    $BodyTemplate = @"
        {
            "channel": "#software",
            "username": "Azure Uptime Bot",
            "text": "$($Env:URL_TO_CHECK) is currently offline; not returning graphql query data",
            "icon_emoji":":bangbang:"
        }
"@

    Invoke-RestMethod -uri $Env:SLACK_CHANNEL_URI -Method Post -body $BodyTemplate -ContentType 'application/json'

    exit 1
}
