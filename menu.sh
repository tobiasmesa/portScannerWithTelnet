subMenuCloudBuilder () {
    clear
    local PS3='Please select the destinations service: '
    local options=("DNS Server(s)" "ESXi Hosts" "ESXi Hosts for the Management Domain" "NSX Controllers (NSX-v) for the Management Domain" "NSX Edge Service Gateways (NSX-v) for the Management Domain" "NSX Edges Nodes for the Management Domain" "NSX Manager (NSX-v) for the Management Domain" "NSX Managers for the Management Domain" "NTP Server(s)" "Platform Service Controllers for the Management/Workload Domains" "SDDC Manager" "vCenter Server for the Management Domain" "Back")
    local opt
    select opt in "${options[@]}"
    do
        case $opt in
            "DNS Server(s)")
                echo "you chose sub item 1"
                ;;
            "SDDC Manager")
                echo "you chose sub item 1"
                ;;
            "ESXi Hosts")
                echo "you chose sub item 2"
                ;;
            "ESXi Hosts for the Management Domain")
                echo "you chose sub item 2"
                ;;
            "NSX Controllers (NSX-v) for the Management Domain")
                echo "you chose sub item 2"
                ;;
            "NSX Edge Service Gateways (NSX-v) for the Management Domain")
                echo "you chose sub item 2"
                ;;     
            "NSX Managers for the Management Domain")
                echo "you chose sub item 2"
                ;;
            "NTP Server(s)")
                echo "you chose sub item 2"
                ;;
            "Platform Service Controllers for the Management/Workload Domains")
                echo "you chose sub item 2"
                ;;
            "vCenter Server for the Management Domain")
                echo "you chose sub item 2"
                ;;            
            "Back")
                menu
                ;;
            *) echo "invalid option $REPLY";;
        esac
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
                echo "you chose sub item 2"
                ;;
            "ESXi Hosts")
                echo "you chose sub item 2"
                ;;
            "ESXi Hosts for Management/Workload Domains")
                echo "you chose sub item 2"
                ;;
            "Federated SDDC Manager Instances")
                echo "you chose sub item 2"
                ;;     
            "Microsoft Certificate Authority Web Enrollment Endpoint")
                echo "you chose sub item 2"
                ;;
            "NSX Controllers (NSX-v) for Management/Workload Domains")
                echo "you chose sub item 2"
                ;;
            "NSX Edges Nodes for Management/Workload Domains")
                echo "you chose sub item 2"
                ;;
            "NSX Manager (NSX-v or NSX-T) for Workload Domains")
                echo "you chose sub item 2"
                ;;
            "NSX Manager (NSX-v) for the Management Domain")
                echo "you chose sub item 2"
                ;;
            "NTP Server(s)")
                echo "you chose sub item 2"
                ;;
                
            "Platform Service Controller for Management/Workload Domains")
                echo "you chose sub item 2"
                ;;
                
            "SFTP-based Backup Destination")
                echo "you chose sub item 2"
                ;;
                
            "vCenter Server for the Management Domain")
                echo "you chose sub item 2"
                ;;
                
            "vCenter Servers for Management/Workload Domains")
                echo "you chose sub item 2"
                ;;
            "VMware Depot (Akamai CDN for depot.vmware.com)")
                echo "you chose sub item 2"
                ;;
            "vRealize Log Insight")
                echo "you chose sub item 2"
                ;;
                
            "vRealize Log Insight (Cluster VIP and Nodes)")
                echo "you chose sub item 2"
                ;;
                
            "vCenter Servers for Management/Workload Domains")
                echo "you chose sub item 2"
                ;;
            "vRealize Log Insight Cluster")
                echo "you chose sub item 2"
                ;;
            "vRealize Operations Manager (Cluster and Nodes)")
                echo "you chose sub item 2"
                ;;
            "vRealize Suite Lifecycle Manager")
                echo "you chose sub item 2"
                ;;
            "Workspace ONE Access (Cluster and Nodes)")
                echo "you chose sub item 2"
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
                echo "you chose sub item 2"
                ;;
            "vCenter Server for the Management Domain")
                echo "you chose sub item 2"
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
