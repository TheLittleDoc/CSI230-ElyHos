cd C:\xampp\apache\logs
# Get-Content "C:\xampp\apache\logs\access.log" | Select-String -NotMatch ' 200 '
# $logs = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String -SimpleMatch "error"

# $logs[-5..-1]

$notfound = Get-Content C:\xampp\apache\logs\access.log | Select-String -pattern ' 404 '

$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
#$notfound

$ips_unorganized = $regex.Matches($notfound)
$ips = @()
for($i=0; $i -lt $ips_unorganized.Count; $i++) {
    $ips += [pscustomobject]@{ "IP" = $ips_unorganized[$i].Value; }
}

#$ips | Where-Object { $_.IP -ilike "1*" }

$ipsoften = $ips | Where-Object { $_.IP -ilike "1*" }
$counts = $ipsoften | Group-Object IP
$counts | Select Count,Name