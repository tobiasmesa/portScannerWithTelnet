connect () {
	read -p "Ingrese la IP del host seleccionado: " host
	read -p "Ingrese el USER: " user
	read -p "Ingrese la PASSWORD: " pass
	read -p "Ingrese ip del TARGET: " target
	echo 'Intentando conectarse ...'
	sshpass -p $pass ssh $user@$host 'bash -s' < ./scanner.sh $target ${ports[@]}
}


subMenuCloudBuilder () {
    clear
    local PS3='Please select the destinations service: '
    local options=("DNS Server(s)" "ESXi Hosts" "ESXi Hosts for the Management Domain" "NSX Controllers (NSX-v) for the Management Domain" "NSX Edge Service Gateways (NSX-v) for the Management Domain" "NSX Edges Nodes for the Management Domain" "NSX Manager (NSX-v) for the Management Domain" "NSX Managers for the Management Domain" "NTP Server(s)" "Platform Service Controllers for the Management/Workload Domains" "SDDC Manager" "vCenter Server for the Management Domain" "Back")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "DNS Server(s)")
                ports=(53)
                ;;
            "SDDC Manager")
                echo "you chose sub item 1"
                ;;
            "ESXi Hosts")
               ports=(67,69)
                ;;
            "ESXi Hosts for the Management Domain")
               ports=()
                ;;
            "NSX Controllers (NSX-v) for the Management Domain")
               ports=()
                ;;
            "NSX Edge Service Gateways (NSX-v) for the Management Domain")
               ports=()
                ;;     
            "NSX Managers for the Management Domain")
               ports=()
                ;;
            "NTP Server(s)")
               ports=()
                ;;
            "Platform Service Controllers for the Management/Workload Domains")
               ports=()
                ;;
            "vCenter Server for the Management Domain")
               ports=()
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
    local options=("Administrative / Management Network(s)" "Cloud Foundation Components" "DNS Server(s)" "ESXi Hosts" "ESXi Hosts for Management/Workload Domains" "Federated SDDC Manager Instances" "Microsoft Certificate Authority Web Enrollment Endpoint" "NSX Controllers (NSX-v) for Management/Workload Domains" "NSX Edges Nodes for Management/Workload Domains" "NSX Manager (NSX-v or NSX-T) for Workload Domains" "NSX Manager (NSX-v) for the Management Domain" "NSX Managers for Management Domain/Workload Domains" "NTP Server(s)" "Platform Service Controller for Management/Workload Domains" "SFTP-based Backup Destination" "vCenter Server for the Management Domain" "vCenter Servers for Management/Workload Domains" "VMware Depot (Akamai CDN for depot.vmware.com)" "vRealize Automation (Cluster and Nodes)" "vRealize Log Insight" "vRealize Log Insight (Cluster VIP and Nodes)" "vRealize Log Insight Cluster" "vRealize Operations Manager (Cluster and Nodes)" "vRealize Suite Lifecycle Manager" "Workspace ONE Access (Cluster and Nodes)" "Back")  
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "DNS Server(s)")
                echo "you chose sub item 1"
                ;;
            "Administrative / Management Network(s)")
                echo "you chose sub item 1"
                ;;
            "Cloud Foundation Components")
               ports=()
                ;;
            "ESXi Hosts")
               ports=()
                ;;
            "ESXi Hosts for Management/Workload Domains")
               ports=()
                ;;
            "Federated SDDC Manager Instances")
               ports=()
                ;;     
            "Microsoft Certificate Authority Web Enrollment Endpoint")
               ports=()
                ;;
            "NSX Controllers (NSX-v) for Management/Workload Domains")
               ports=()
                ;;
            "NSX Edges Nodes for Management/Workload Domains")
               ports=()
                ;;
            "NSX Manager (NSX-v or NSX-T) for Workload Domains")
               ports=()
                ;;
            "NSX Manager (NSX-v) for the Management Domain")
               ports=()
                ;;
            "NTP Server(s)")
               ports=()
                ;;
                
            "Platform Service Controller for Management/Workload Domains")
               ports=()
                ;;
                
            "SFTP-based Backup Destination")
               ports=()
                ;;
                
            "vCenter Server for the Management Domain")
               ports=()
                ;;
                
            "vCenter Servers for Management/Workload Domains")
               ports=()
                ;;
            "VMware Depot (Akamai CDN for depot.vmware.com)")
               ports=()
                ;;
            "vRealize Log Insight")
               ports=()
                ;;
                
            "vRealize Log Insight (Cluster VIP and Nodes)")
               ports=()
                ;;
                
            "vCenter Servers for Management/Workload Domains")
               ports=()
                ;;
            "vRealize Log Insight Cluster")
               ports=()
                ;;
            "vRealize Operations Manager (Cluster and Nodes)")
               ports=()
                ;;
            "vRealize Suite Lifecycle Manager")
               ports=()
                ;;
            "Workspace ONE Access (Cluster and Nodes)")
               ports=()
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
    local options=("SDDC Manager" "Cloud Builder" "Platform Service Controllers for the Management/Workload Domains" "vCenter Server for the Management Domain" "Back")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "Cloud Builder")
                echo "you chose sub item 1"
                ;;
            "SDDC Manager")
                echo "you chose sub item 1"
                ;;
            "Platform Service Controllers for the Management/Workload Domains")
               ports=()
                ;;
            "vCenter Server for the Management Domain")
               ports=()
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
PS3='Please select source service: '
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
