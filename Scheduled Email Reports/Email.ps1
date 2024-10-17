
function Send-Email($body) {

    $from = "elysium.hosack@mymail.champlain.edu"
    $to = $from

    $subject = "Automated Report"
    $password = "zbrw rvoy nbnv adsi" | ConvertTo-SecureString -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $from, $password
    Send-MailMessage -From $from -To $to -Subject $subject -Body $body -SmtpServer "smtp.gmail.com" -Port 587 -UseSsl -Credential $credential
}