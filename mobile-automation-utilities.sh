function get-ipa-app-version() {
    unzip -p "$1" 'Payload/*.app/Info.plist' | strings | awk -F'[<>]' '/CFBundleShortVersionString/{getline; print $3}'
}

function get-ipa-app-build-number() {
    unzip -p "$1" 'Payload/*.app/Info.plist' | strings | awk -F'[<>]' '/CFBundleVersion/{getline; print $3}' | sed 's/[^0-9.]//g'
}

function get-simulator-app-version() {
    /usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' '$1/Info.plist'
}

function get-simulator-app-build-number() {
    /usr/libexec/PlistBuddy -c 'Print CFBundleVersion' '$1/Info.plist' | sed 's/[^0-9.]//g'
}

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
