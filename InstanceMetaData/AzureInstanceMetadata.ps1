Connect-AzAccount -SubscriptionName "Free Trial"
set-azcontext -SubscriptionName "Free Trial"
function Get-Data {
    param (
        $Key,
        $ComputerName
    )
    $AzureVM = Get-AzVM -Name $ComputerName
    $JsonOP = $AzureVM | ConvertTo-Json
    #Write-Output "$JsonOP"
    $JsonObj = $JsonOP | ConvertFrom-Json
    foreach ($parameter in $JsonObj.psobject.Properties) {
        if ($parameter.TypeNameOfValue -eq "System.Management.Automation.PSCustomObject") {
            foreach ($param in $parameter.Value.psobject.Properties) {
                if ($param.Name -eq $Key){     
                    $Output = $parameter.Value.$Key
                    }
                }
        }
        else {
            if ($parameter.Name -eq $Key){
                $Output = $JsonObj.$Key
            }
        }
    }

    if ($null -eq $Output){
        Write-Output "Parameter not found"
    }
    else {
        return $Output
    }
}

Get-Data -Key "resourcegroupname" -ComputerName "example-machine"

