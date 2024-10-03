# (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "ethernet0" }).IPAddress
# (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "ethernet0" }).PrefixLength
# Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "ethernet0" }).ServerAddresses[0]