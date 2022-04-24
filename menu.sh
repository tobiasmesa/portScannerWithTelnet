PS3='Please select source service: '
options=("Cloud Builder" "SDDC Manager" "Administrative / Managment Networks" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Cloud Builder")
            echo "you chose choice 1"
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



subMenuCloudBuilder () {
    #local PS3 = 'Please select the destinations service':
   # local options = ("")
}
