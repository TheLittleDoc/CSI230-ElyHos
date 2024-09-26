function Get-Visitors($page, $code, $browser) {
    $match_page = " " + $page + " "
    $match_code = " " + $code + " "
    $match_browser = " " + $browser + "/"
    $logs = Get-Content C:\xampp\apache\logs\access.log | Select-String $match_page | Select-String $match_code | Select-String $match_browser
   
    $regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}[' ']"

    $ips = $regex.Matches($logs)
    $ip_objs = @()
    for($i=0; $i -lt $ips.Count; $i++) {
        $ip_objs += [pscustomobject]@{ "IP" = $ips[$i].Value; }
    }

    return $ip_objs

}