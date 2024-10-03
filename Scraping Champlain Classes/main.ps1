. (Join-Path $PSScriptRoot ClassQueries.ps1)
$classes = Get-ChamplainClasses

$classes | Where-Object { ($_.Instructor   -ilike "Furkan Paligu") } |
           Select -Property "Class Code", Instructor, Location, Days, "Time Start", "Time End" |
           Format-Table -AutoSize

$classes | Where-Object { ($_.Location   -ilike "JOYC 310") -and ($_.Days -contains "Monday") } |
           Sort-Object "Time Start" |
           Select -Property "Time Start", "Time End", "Class Code" |
           Format-Table -AutoSize

$ITSInstructors = $classes  | Where-Object  {
                                                ($_."Class Code" -ilike "SYS*") -or `
                                                ($_."Class Code" -ilike "NET*") -or `
                                                ($_."Class Code" -ilike "SEC*") -or `
                                                ($_."Class Code" -ilike "FOR*") -or `
                                                ($_."Class Code" -ilike "CSI*") -or `
                                                ($_."Class Code" -ilike "DAT*")
                                            }`
                            | Sort-Object "Instructor"`
                            | Select "Instructor" -Unique
$ITSInstructors

$classes | Where-Object { ($_.Instructor -in $ITSInstructors.Instructor) } |
           Group-Object "Instructor" |
           Select Count, Name |
           Sort-Object Count -Descending |
           Format-Table -AutoSize
