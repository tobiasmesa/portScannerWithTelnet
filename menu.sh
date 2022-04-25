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
            echo "you chose choice 2"
            ;;
        "Administrative / Managment Networks")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

}

menu
