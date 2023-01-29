$Computer = @{
                    'Brand' = 'Dell'
                    'Model' = 'V12'
                    'Specs' = @{
                                    'OperatingSystem' = @{
                                                'OSName' = 'Microsoft Windows 10'
                                             }
                               }
                 }

function Get-Value {
    param (
        $Key
    )
   
    if ($key -in $Computer.Keys) {
        if ($null -eq $Computer.$key.keys) {
            write-output "value is $($Computer.$key)"
        }
        else {
            foreach ($attribute in $Computer.$key.keys) {
                write-output "value is $($($($Computer.$Key).$attribute).Values)" 
            }
        }
        }
    else {
        foreach ($value in $Computer.Values) {
            if ($value -is [hashtable]) {
                if ($value.Contains("$key")) {
                    "value is $($($($Computer.Values).$Key).Values)"
                }
                else {
                #if($value.Values.GetType().Name -eq "ValueCollection" ) {
                    write-output "value is $($($value.Values).$Key)"
                }
                }
            }
        }
}

Get-Value -Key 'specs'

