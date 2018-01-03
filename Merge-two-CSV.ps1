############################
# Merge-two-CSV

$CSV_A = Import-CSV -Path C:\Temp\CSVA.csv
$CSV_B = Import-CSV -Path C:\Temp\CSVB.csv

#################### ####################
# C:\Temp\CSVA.csv # # C:\Temp\CSVB.csv #
#                  # #                  #
# Number,Price     # # Number,Price     #
# 1111,50          # # 1111,150         #
# 2222,50          # # 2222,150         #
# 3333,40          # # 3333,140         #
                

############################
# region Result 1

$Result1 = @{}
foreach ($x in $CSV_A + $CSV_B) 
    { 
     $Result1.$($x.Number) += [System.Math]::Round(([single]$x.Price ),2)
     }

$Result1 
#endregion

############################
# region Result 2
$Result2 = $CSV_A + $CSV_B | 
    Group-Object -Property Number | 
        ForEach-Object {
                        [PSCustomObject]@{'Number' = $_.Name
                                          'Price' = [System.Math]::Round(($_.Group | Measure-Object -Property Price -Sum).Sum,2)} 
                        }

$Result2
#endregion