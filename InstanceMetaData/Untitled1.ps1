$azurevm = Get-azVM -Name example-machine
$JsonOP = $AzureVM | ConvertTo-Json
#Write-Output "$JsonOP" 
$JsonObj = $JsonOP | ConvertFrom-Json