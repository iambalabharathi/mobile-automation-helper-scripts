function list-connected-iphones-info() {
    printf "%-40s %-25s %-10s\n" "UDID" "Device Name" "iOS Version"
    printf "%-40s %-25s %-10s\n" "---------------------------------------------------------------------------------"

    for udid in $(idevice_id -l); do
        name=$(ideviceinfo -u "$udid" -k DeviceName)
        version=$(ideviceinfo -u "$udid" -k ProductVersion)
        printf "%-40s %-25s %-10s\n" "$udid" "$name" "$version"
    done
    
    printf "%-40s %-25s %-10s\n" "---------------------------------------------------------------------------------"
}
