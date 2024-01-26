# Clear the screen
clear

# 1 Get IPv4 address from Ethernet0 Interface
#(Get-NetIPAddress -AddressFamily IPv4 | where-object {$_.InterfaceAlias -ilike "Ethernet0"} ).IPAddress
# 2 Get IPv4 Prefixlength from Ethernet0 Interface
#(Get-NetIPAddress -AddressFamily IPv4 | where-object {$_.InterfaceAlias -ilike "Ethernet0"} ).PrefixLength
# 3 Show what classes there is of Win32 library that starts with net
#Get-wmiobject -list | Where-Object {$_.Name -ilike "*net*"}
# 4 Sort Alphabetically
#Get-WmiObject -list | Where-Object {$_.Name -ilike "Win32_*net*"} | Sort-Object name
# 5 Get DHCP Server IP
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer
# 6 Hide the table headers
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | `
# Select DHCPServer  | Format-Table -HideTableHeaders
# 7 Get DNS Server IPs for Ethernet interface and only display the first one
#(Get-DnsClientServerAddress -AddressFamily IPv4 | `
#Where-Object {$_.InterfaceAlias -ilike "Ethernet0" }).ServerAddresses | Select-Object -First 1

# 8 List all files in your working directory
#cd "C:\Users\champuser\SYS-320-Automation-and-scripting\week1"
#$files=(Get-ChildItem)
#for ($j=0; $j -le $files.Count; $j++){
  #  if($files[$j].Name -ilike "*ps1"){
  #  Write-Host $files[$j].Name
 #   }
#}

# 9 Create a folder called "outfolder" if it does not already exist
$folderpath = "C:\Users\champuser\SYS-320-Automation-and-scripting\week2\outfolder"
if ( $folderpath){
    Write-Host "Folder Already Exists"
}