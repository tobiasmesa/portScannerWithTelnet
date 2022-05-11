connect () {
	read -p "Ingrese la IP del host seleccionado: " host
	read -p "Ingrese el USER: " user
	read -p "Ingrese la PASSWORD: " pass
	read -p "Ingrese ip del TARGET: " target
	echo    'Intentando conectarse ...'
	sshpass -p $pass ssh $user@$host 'bash -s' < ./scanner.sh $target ${ports[@]}
    sleep 7
    menu
}

pingToMe () {
    read -p "Ingrese la IP del host seleccionado" host
    ping -c 3 $host
    
    sleep 7 
    menu

}


subMenuCloudBuilder () {
    clear
    local PS3='Please select the destinations service: '
    local options=("Back" "DNS Server(s)" "ESXi Hosts" "ESXi Hosts for the Management Domain" "NSX Controllers (NSX-v) for the Management Domain" "NSX Edge Service Gateways (NSX-v) for the Management Domain" "NSX Edges Nodes for the Management Domain" "NSX Manager (NSX-v) for the Management Domain" "NSX Managers for the Management Domain" "NTP Server(s)" "Platform Service Controllers for the Management/Workload Domains" "SDDC Manager" "vCenter Server for the Management Domain" )
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "DNS Server(s)")
                ports=(53)
                ;;
            "SDDC Manager")
                ports=(443,22)
                ;;
            "ESXi Hosts")
               ports=(67,69)
                ;;
            "ESXi Hosts for the Management Domain")
               ports=(902,22,68,443)
                ;;
            "NSX Controllers (NSX-v) for the Management Domain")
               ports=(443,22)
                ;;
            "NSX Edge Service Gateways (NSX-v) for the Management Domain")
               ports=(443,22)
                ;;     
            "NSX Manager (NSX-v) for the Management Domain")
               ports=(443,22)
                ;;
            "NSX Managers for the Management Domain")
               ports=(443,22)
                ;;
            "NSX Edges Nodes for the Management Domain")
               ports=(443,22)
                ;;
            "NTP Server(s)")
               ports=(123)
                ;;
            "Platform Service Controllers for the Management/Workload Domains")
               ports=(5480,22,443)
                ;;
            "vCenter Server for the Management Domain")
               ports=(902,22,443,2014,5480)
                ;;            
            "Back")
                menu
                ;;
            *) echo "invalid option $REPLY";;
        esac
        connect
    done
}

subMenuSDDCManager () {
    clear
    local PS3='Please select the destinations service: '
    local options=("Back" "Administrative / Management Network(s)"  "Cloud Foundation Components" "DNS Server(s)" "ESXi Hosts" "ESXi Hosts for Management/Workload Domains" "Federated SDDC Manager Instances" "Microsoft Certificate Authority Web Enrollment Endpoint" "NSX Controllers (NSX-v) for Management/Workload Domains" "NSX Edges Nodes for Management/Workload Domains" "NSX Manager (NSX-v or NSX-T) for Workload Domains" "NSX Manager (NSX-v) for the Management Domain" "NSX Managers for Management Domain/Workload Domains" "NTP Server(s)""Platform Service Controller for Management/Workload Domains" "SFTP-based Backup Destination" "vCenter Server for the Management Domain" "vCenter Servers for Management/Workload Domains" "vCenter Servers for Workload Domains" "VMware Depot (Akamai CDN for depot.vmware.com)" "vRealize Automation (Cluster and Nodes)" "vRealize Log Insight" "vRealize Log Insight (Cluster VIP and Nodes)" "vRealize Log Insight Cluster" "vRealize Operations Manager (Cluster and Nodes)" "vRealize Suite Lifecycle Manager" "Workspace ONE Access (Cluster and Nodes)")  
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "DNS Server(s)")
                ports=(53)
                ;;
            "Administrative / Management Network(s)")
                ports=(443)
                ;;
            "Cloud Foundation Components")
               echo "Hay que hacer ping"
                ;;
            "ESXi Hosts")
               ports=(4045,32766,32767,2049,111)
                ;;
            "ESXi Hosts for Management/Workload Domains")
               ports=(443,22)
                ;;
            "Federated SDDC Manager Instances")
               ports=(443)
                ;;     
            "Microsoft Certificate Authority Web Enrollment Endpoint")
               ports=(433)
                ;;
            "NSX Controllers (NSX-v) for Management/Workload Domains")
               ports=(22,443)
                ;;
            "NSX Edges Nodes for Management/Workload Domains")
               ports=(22,443)
                ;;
            "NSX Manager (NSX-v or NSX-T) for Workload Domains")
               ports=(22,443)
                ;;
            "NSX Manager (NSX-v) for the Management Domain")
               ports=(22,443)
                ;;
            "NTP Server(s)")
               ports=(123)
                ;;
                
            "Platform Service Controller for Management/Workload Domains")
               ports=(22,443,7444)
                ;;
                
            "SFTP-based Backup Destination")
               ports=(22)
                ;;
                
            "vCenter Server for the Management Domain")
               ports=(5480)
                ;;
            "vCenter Servers for Workload Domains")
               ports=(5480)
                ;;
            "vCenter Servers for Management/Workload Domains")
               ports=(443,22)
                ;;
            "VMware Depot (Akamai CDN for depot.vmware.com)")
               ports=(443)
                ;;
            "vRealize Log Insight")
               ports=(9543)
                ;;       
            "vRealize Log Insight (Cluster VIP and Nodes)")
               ports=(443,22)
                ;;
                
            "vRealize Log Insight Cluster")
               ports=(9543,443)
                ;;
             "vRealize Automation (Cluster and Nodes)")
               ports=(443)
                ;;
            "vRealize Operations Manager (Cluster and Nodes)")
               ports=(443)
                ;;
            "vRealize Suite Lifecycle Manager")
               ports=(443,22)
                ;;
            "Workspace ONE Access (Cluster and Nodes)")
               ports=(443,22)
                ;;
            "Back")
                menu
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

subMenuAdminManagmentNet () {
    clear
    local PS3='Please select the destinations service: '
    local options=("Back" "SDDC Manager" "Cloud Builder" "Platform Service Controllers for the Management/Workload Domains" "vCenter Server for the Management Domain")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Cloud Builder")
                pingToMe
                ;;
            "SDDC Manager")
               pingToMe
                ;;
            "Platform Service Controllers for the Management/Workload Domains")
              pingToMe
                ;;
            "vCenter Server for the Management Domain")
               pingToMe
                ;;
            "Back")
                menu
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}


menu () {
clear

PS3='
Please select source service: '

options=("Cloud Builder" "SDDC Manager" "Administrative / Managment Networks" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Cloud Builder")
            subMenuCloudBuilder
            ;;
        "SDDC Manager")
            subMenuSDDCManager
            ;;
        "Administrative / Managment Networks")
            subMenuAdminManagmentNet
            ;;
        "Quit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}




menu
