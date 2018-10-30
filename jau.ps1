$yamlpath = "C:\ProgramData\Datadog\datadog.yaml"
$dlpath = "C:/datadog-agent-6-latest.amd64.msi"
Remove-Item –path $yamlpath
(New-Object System.Net.WebClient).DownloadFile("https://s3.amazonaws.com/ddagent-windows-stable/datadog-agent-6-latest.amd64.msi", $dlpath)
