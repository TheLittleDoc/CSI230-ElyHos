function Get-IOCList() {
    $page = Invoke-WebRequest -TimeoutSec 5 "http://10.0.17.5/IOC.html"
    $tr_elements = $page.ParsedHtml.body.getElementsByTagName("tr")
    $ioc_table = @()
    for( $i = 1; $i -lt $tr_elements.length; $i++) {
        $td_elements = $tr_elements[$i].getElementsByTagName("td")
        $ioc_table += [pscustomobject]@{
            "Pattern" = $td_elements[0].innerText;
            "Explanation" = $td_elements[1].innerText;
        }
    }
    return $ioc_table
}
