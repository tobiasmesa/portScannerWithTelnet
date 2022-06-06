
Function port-scan-udp {
    param($hosts,$ports)
    if (!$ports) {
      Write-Host "usage: port-scan-udp <host|hosts> <port|ports>"
      Write-Host " e.g.: port-scan-udp 192.168.1.2 445`n"
      return
    }
    $out = ".\scanresults.txt"
    foreach($p in [array]$ports) {
     foreach($h in [array]$hosts) {
      $x = (gc $out -EA SilentlyContinue | select-string "^$h,udp,$p,")
      if ($x) {
        gc $out | select-string "^$h,udp,$p,"
        continue
      }
      $msg = "$h,udp,$p,"
      $u = new-object system.net.sockets.udpclient
      $u.Client.ReceiveTimeout = 500
      $u.Connect($h,$p)
      # Send a single byte 0x01
      [void]$u.Send(1,1)
      $l = new-object system.net.ipendpoint([system.net.ipaddress]::Any,0)
      $r = "Filtered"
      try {
        if ($u.Receive([ref]$l)) {
          # We have received some UDP data from the remote host in return
          $r = "Open"
        }
      } catch {
        if ($Error[0].ToString() -match "failed to respond") {

          if ((Get-wmiobject win32_pingstatus -Filter "address = '$h' and Timeout=1000 and ResolveAddressNames=false").StatusCode -eq 0) {
            # We can ping the remote host, so we can assume that ICMP is not
            # filtered. And because we didn't receive ICMP port-unreachable before,
            # we can assume that the remote UDP port is open
            $r = "Open"
          }
        } elseif ($Error[0].ToString() -match "forcibly closed") {
          # We have received ICMP port-unreachable, the UDP port is closed
          $r = "Closed"
        }
      }
      $u.Close()
      $msg += $r
      Write-Host "$msg"
      echo $msg >>$out
     }
    }
  }
  
Function port-scan-tcp {
    param($hosts,$ports)
    if (!$ports) {
      Write-Host "usage: port-scan-tcp <host|hosts> <port|ports>"
      Write-Host " e.g.: port-scan-tcp 192.168.1.2 445`n"
      return
    }
    $out = ".\scanresults.txt"
    foreach($p in [array]$ports) {
     foreach($h in [array]$hosts) {
      $x = (gc $out -EA SilentlyContinue | select-string "^$h,tcp,$p,")
      if ($x) {
        gc $out | select-string "^$h,tcp,$p,"
        continue
      }
      $msg = "$h,tcp,$p,"
      $t = new-Object system.Net.Sockets.TcpClient
      $c = $t.ConnectAsync($h,$p)
      for($i=0; $i -lt 10; $i++) {
        if ($c.isCompleted) { break; }
        sleep -milliseconds 100
      }
      $t.Close();
      $r = "Filtered"
      if ($c.isFaulted -and $c.Exception -match "actively refused") {
        $r = "Closed"
      } elseif ($c.Status -eq "RanToCompletion") {
        $r = "Open"
      }
      $msg += $r
      Write-Host "$msg"
      echo $msg >>$out
     }
    }
  }

function get-Ip 
{
  $a =  Read-Host "Enter the IP service: "
  return $a
}

function Show-Menu {
    param (
        [string]$Title = 'Menu',
        [string]$opt1 = 'Cloud Builder',
        [string]$opt2 = 'SDDC Manager',
        [string]$opt3 = 'Administrative / Managment Networks'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: $opt1"
    Write-Host "2: $opt2"
    Write-Host "3: $opt3"
    Write-Host "Q: Press 'Q' to quit."
}

function Show-SubMenuCM {
    param (
        [string]$Title = 'Test Cloud Builder ports'
    )
    Clear-Host 
    Write-Host "================ $Title ================"
    
    Write-Host "1: DNS Server(s)."
    Write-Host "2: ESXi Hosts."
    Write-Host "3: ESXi Hosts for the Management Domain."
    Write-Host "4: NSX Controllers (NSX-v) for the Management Domain."
    Write-Host "5: NSX Edge Service Gateways (NSX-v) for the Management Domain."
    Write-Host "6: NSX Edges Nodes for the Management Domain."
    Write-Host "7: NSX Manager (NSX-v) for the Management Domain."
    Write-Host "8: NSX Managers for the Management Domain."
    Write-Host "9: NTP Server(s)."
    Write-Host "10: Platform Service Controllers for the Management/Workload Domains."
    Write-Host "11: SDDC Manager."
    Write-Host "12: vCenter Server for the Management Domain."
    Write-Host "Q: Press 'Q' to go back."
    Write-Host "========================================"
}


do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection: "
    switch ($selection)
    {
    '1' {
        Show-SubMenuCM
        $subselection = Read-Host "Please make a selection: "
          switch($subselection)
          {
            '1'{
              $ip = get-Ip
              $s += port-scan-tcp $ip 53,30,32
            }
            '2' {
              $s += port-scan-tcp 10.10.60.20 3,20,12
            }
            '3' {

            }
            '4'{
              Write-Host "AAAAAAAA" 
             }
             '5' {
 
             }
             '6' {
 
             }
             '7'{
              Write-Host "AAAAAAAA" 
             }
             '8' {
 
             }
             '9' {
 
             }
             '10'{
              Write-Host "AAAAAAAA" 
             }
             '11' {
 
             }
             '12' {
 
             }

          }


    } '2' {
    'You chose option #2'
    } '3' {
      $s | Out-File -FilePath .\Process.csv
    }
    }
    pause
 }
 until ($selection -eq 'q')