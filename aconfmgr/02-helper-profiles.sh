function CheckBoardName() {
    local target_board="$1"
    local sys_board=""

    if [[ -r /sys/class/dmi/id/board_name ]]; then
        sys_board="$(cat /sys/class/dmi/id/board_name)"
    fi

    [[ "$sys_board" == "$target_board" ]]
}

# Specific wrapper for the RedmiBook Pro 16 2026.
# Usage: if IsRedmiBookPro; then ...
function IsRedmiBookPro() {
    CheckBoardName "TM2425"
}
