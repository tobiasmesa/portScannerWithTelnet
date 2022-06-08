
Function port-scan-udp {
    param($hosts,$ports)
    if (!$ports) {
      Write-Host "usage: port-scan-udp <host|hosts> <port|ports>"
      Write-Host " e.g.: port-scan-udp 192.168.1.2 445`n"
      return
    }
    $out = ".\scan.txt"
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
    $out = ".\scan.csv"
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
    Write-Host " "
    Write-Host " Los resultados de los scaneos se encuentran en el archivo scan.csv "
    Write-Host " "
    Write-Host "1: $opt1"
    Write-Host "2: $opt2"
    Write-Host "3: $opt3"
    Write-Host "Q: Press 'Q' to quit."
    Write-Host " "
}


function Show-SubMenuAMN {
  param (
      [string]$Title = 'Test Administrator Managment Network ports'
  )
  Clear-Host 
  Write-Host "================ $Title ================"
  Write-Host "1: Platform Service Controllers for the Management/Workload Domains."
  Write-Host "2: SDDC Manager."
  Write-Host "3: Cloud Builder."
  Write-Host "Q: Press 'Q' to go back."
  Write-Host "========================================"
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

function Show-SubMenuSDDC {
  param (
      [string]$Title = 'Test SDDCManager ports'
  )
  Clear-Host 
  Write-Host "================ $Title ================"
  Write-Host "1: DNS Server(s)."
  Write-Host "2: Administrative / Management Network(s)."
  Write-Host "3: Cloud Foundation Components."
  Write-Host "4: ESXi Hosts."
  Write-Host "5: ESXi Hosts for Management/Workload Domains."
  Write-Host "6: Federated SDDC Manager Instances."
  Write-Host "7: Microsoft Certificate Authority Web Enrollment Endpoint."
  Write-Host "8: NSX Controllers (NSX-v) for Management/Workload Domains."
  Write-Host "9: NSX Manager (NSX-v or NSX-T) for Workload Domains."
  Write-Host "10: NSX Managers for Management Domain/Workload Domains."
  Write-Host "11: NTP Server(s)."
  Write-Host "12: Platform Service Controller for Management/Workload Domains." 
  Write-Host "13: SFTP-based Backup Destination."
  Write-Host "14: vCenter Server for the Management Domain." 
  Write-Host "15: vCenter Servers for Workload Domains."
  Write-Host "16: vCenter Servers for Management/Workload Domains."
  Write-Host "17: VMware Depot (Akamai CDN for depot.vmware.com)." 
  Write-Host "18: vRealize Log Insight."
  Write-Host "19: vRealize Log Insight (Cluster VIP and Nodes)." 
  Write-Host "20: vRealize Log Insight Cluster."
  Write-Host "21: vRealize Automation (Cluster and Nodes)." 
  Write-Host "22: vRealize Operations Manager (Cluster and Nodes)."
  Write-Host "23: vRealize Suite Lifecycle Manager" 
  Write-Host "24: Workspace ONE Access (Cluster and Nodes)" 
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
              $ports = 53
              $s += port-scan-tcp $ip $ports
            }
            '2' {
              $ip = get-Ip
              $ports = 443
              $s += port-scan-tcp $ip $ports
            }
            '3' {
              $ip = get-Ip
              $ports = 4045,32766,32767,2049,111
              $s += port-scan-tcp $ip $ports
            }
            '4'{
              $ip = get-Ip
              $ports = 902,22,68,443
              $s += port-scan-tcp $ip $ports
             }
             '5' {
              $ip = get-Ip
              $ports = 443,22
              $s += port-scan-tcp $ip $ports
             }
             '6' {
              $ip = get-Ip
              $ports = 443,22
              $s += port-scan-tcp $ip $ports
             }
             '7'{
              $ip = get-Ip
              $ports = 443,22
              $s += port-scan-tcp $ip $ports
             }
             '8' {
              $ip = get-Ip
              $ports = 443,22
              $s += port-scan-tcp $ip $ports
             }
             '9' {
              $ip = get-Ip
              $ports = 443,22
              $s += port-scan-tcp $ip $ports
             }
             '10'{
              $ip = get-Ip
              $ports = 123
              $s += port-scan-tcp $ip $ports
             }
             '11' {
              $ip = get-Ip
              $ports = 5480,22,443
              $s += port-scan-tcp $ip $ports
             }
             '12' {
              $ip = get-Ip
              $ports = 902,22,443,2014,5480
              $s += port-scan-tcp $ip $ports
             }

          }

    } 
    '2' {
      Show-SubMenuSDDC
      $subselection = Read-Host "Please make a selection: "
        switch($subselection)
        {
          '1'{
            $ip = get-Ip
            $ports = 53
            $s += port-scan-tcp $ip $ports
          }
          '2' {
            $ip = get-Ip
            $ports = 443
            $s += port-scan-tcp $ip $ports
          }
          '3' {
            $ip = get-Ip
            ping $ip
          }
          '4'{
            $ip = get-Ip
            $ports = 4045,32766,32767,2049,111
            $s += port-scan-tcp $ip $ports
           }
           '5' {
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
           '6' {
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
           '7'{
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
           '8' {
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
           '9' {
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
           '10'{
            $ip = get-Ip
            $ports = 22,443
            $s += port-scan-tcp $ip $ports
           }
           '11' {
            $ip = get-Ip
            $ports = 22,443
            $s += port-scan-tcp $ip $ports
           }
           '12' {
            $ip = get-Ip
            $ports = 123
            $s += port-scan-tcp $ip $ports
           }
           '13'{
            $ip = get-Ip
            $ports = 22,443,744
            $s += port-scan-tcp $ip $ports
          }
          '14' {
            $ip = get-Ip
            $ports = 22
            $s += port-scan-tcp $ip $ports
          }
          '15' {
            $ip = get-Ip
            $ports = 5480
            $s += port-scan-tcp $ip $ports
          }
          '16'{
            $ip = get-Ip
            $ports = 5480
            $s += port-scan-tcp $ip $ports
           }
           '17' {
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
           '18' {
            $ip = get-Ip
            $ports = 443
            $s += port-scan-tcp $ip $ports
           }
           '19'{
            $ip = get-Ip
            $ports = 9543
            $s += port-scan-tcp $ip $ports
           }
           '20' {
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
           '21' {
            $ip = get-Ip
            $ports = 9543,443
            $s += port-scan-tcp $ip $ports
           }
           '22'{
            $ip = get-Ip
            $ports =  443
            $s += port-scan-tcp $ip $ports
           }
           '23' {
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
           '24' {
            $ip = get-Ip
            $ports = 443,22
            $s += port-scan-tcp $ip $ports
           }
    } 
  }
    '3' {
      Show-SubMenuAMN
      $subselection = Read-Host "Please make a selection: "
      switch($subselection)
      {
        '1'{
          $ip = get-Ip
          ping $ip
        }
        '2' {
          $ip = get-Ip
          ping $ip
        }
        '3' {
          $ip = get-Ip
          ping $ip
        }
  } 
    }
    }
    $s | Out-File -FilePath .\Process.csv
    
 }
 until ($selection -eq 'q')