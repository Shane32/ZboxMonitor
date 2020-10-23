[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$progressPreference = "silentlyContinue"
$SlackChannelUri = $Env:SLACK_CHANNEL_URI

"---Testing https://zbox2.blob.core.windows.net/static/index.html"
$response5 = Invoke-WebRequest -Uri ("https://zbox2.blob.core.windows.net/static/index.html") -Method Get -UseBasicParsing
$response5
if (!$response5 -or !$response5.StatusCode -eq 200) {
    $BodyTemplate = @"
        {
            "channel": "#software",
            "username": "Azure Uptime Bot",
            "text": "https://zbox2.blob.core.windows.net/static/index.html is currently offline; not returning 200 status code",
            "icon_emoji":":bangbang:"
        }
"@

    Invoke-RestMethod -uri $SlackChannelUri -Method Post -body $BodyTemplate -ContentType 'application/json'

    exit 1
}

"---Testing https://www.zbox.com---"
$response4 = Invoke-WebRequest -Uri ("https://www.zbox.com") -Method Get -UseBasicParsing
$response4
if (!$response4 -or !$response4.StatusCode -eq 200) {
    $BodyTemplate = @"
        {
            "channel": "#software",
            "username": "Azure Uptime Bot",
            "text": "https://www.zbox.com/ is currently offline; not returning 200 status code",
            "icon_emoji":":bangbang:"
        }
"@

    Invoke-RestMethod -uri $SlackChannelUri -Method Post -body $BodyTemplate -ContentType 'application/json'

    exit 1
}

"---Testing http://zbox.com---"
$response = Invoke-WebRequest -Uri ("http://zbox.com") -Method Get -UseBasicParsing
$response
if (!$response -or !$response.StatusCode -eq 200) {
    $BodyTemplate = @"
        {
            "channel": "#software",
            "username": "Azure Uptime Bot",
            "text": "http://zbox.com/ is currently offline; not returning 200 status code",
            "icon_emoji":":bangbang:"
        }
"@

    Invoke-RestMethod -uri $SlackChannelUri -Method Post -body $BodyTemplate -ContentType 'application/json'

    exit 1
}

"---Testing https://api.zbox.com/api/graphql---"
$weburi2 = "https://api.zbox.com/api/graphql"
$body2 = @"
{"query":"{ v1 { categories(where: [{path: \"ShowOnHomePage\", comparison: equal, value: \"true\"}]) { description displayOrder id metaDescription metaKeywords metaTitle name parentCategoryId picture { altAttribute id mimeType seoFilename size thumbnail(size: 100) { size url __typename } titleAttribute __typename } showOnHomePage __typename } __typename } }","variables":null}
"@
$body3 = @"
{"query":"{ v1 { categories(where: [{path: \"ShowOnHomePage\", comparison: equal, value: \"true\"}]) { id } } }","variables":null}
"@
$response2 = ""
$response2 = Invoke-RestMethod -Uri $weburi2 -Method Post -Body $body2 -ContentType 'application/json'
if ($response2.data.v1.categories.Count -gt 0) {
    "Found categories:"
    $response2.data.v1.categories.Count
    "First category:"
    $response2.data.v1.categories[0]
} else {
    $BodyTemplate = @"
        {
            "channel": "#software",
            "username": "Azure Uptime Bot",
            "text": "https://api.zbox.com/api/graphql is currently offline; not providing graph",
            "icon_emoji":":bangbang:"
        }
"@

    Invoke-RestMethod -uri $SlackChannelUri -Method Post -body $BodyTemplate -ContentType 'application/json'

    exit 1
}

"---Testing https://admin.zbox.com/Admin---"
$response3 = Invoke-WebRequest -Uri ("https://admin.zbox.com/Admin") -Method Get -UseBasicParsing
$response3
if (!$response3 -or !$response3.StatusCode -eq 200) {
    $BodyTemplate = @"
        {
            "channel": "#software",
            "username": "Azure Uptime Bot",
            "text": "https://admin.zbox.com/Admin is currently offline; not returning 200 status code",
            "icon_emoji":":bangbang:"
        }
"@

    Invoke-RestMethod -uri $SlackChannelUri -Method Post -body $BodyTemplate -ContentType 'application/json'

    exit 1
}

