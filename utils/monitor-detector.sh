#!/bin/bash

# Source logger module
source /etc/bash-logger.sh
logger_register_module "monitor-detector" "$LOG_LEVEL_DBG"

__match_edid() {
    local -r edid_data="$1"
    local -r edid_pattern="$2"

    # Check if data string is empty
    if [[ -z "$edid_data" ]]; then
        return 1 # Empty data
    fi

    # Match against the pattern
    if [[ "$edid_data" == $edid_pattern ]]; then
        return 0 # Matched
    else
        return 1 # Not matched
    fi
}

__run_callback() {
    local -r callback=("$@")

    # Check if any non-white characters has been passed to function
    if [[ -z "${callback[0]// /}" ]]; then
        log_err "No command or script provided"
        return 1
    fi

    # Check if it's executable file
    if [[ -f "${callback[0]}" && -x "${callback[0]}" ]]; then
        # It's executable
        local -r callback_file="${callback[0]}"
        local -r callback_args_string="${callback[*]:1}"
        local -r callback_args_array=("${callback[@]:1}")

        local log_message="Callback is executable [${callback_file}]"
        log_message+=" with args [${callback_args_string}]"
        log_inf "${log_message}"

        # Run executable with args
        "$callback_file" "${callback_args_array[@]}"
    else
        # It's bash command(s)
        local -r callback_commands=("${callback[@]}")
        log_inf "Callback is command(s)"
        bash -c "${callback_commands[*]}"
    fi
}

monitor_detector_check_presence() {
    log_inf "Checking presence of DRM device"
    local -r edid_pattern="$1"
    shift 
    local -a callback=("$@")

    # Loop through DRM devices
    for drm_device in /sys/class/drm/*; do
        # Get the path to edid file
        edid_file="$drm_device/edid"

        # Check if edid file exists
        if [[ -f "$edid_file" ]]; then
            # Read the EDID data from the file and strip non-printable chars
            edid_data=$(tr -cd '[:print:]' < "$edid_file")

            # Call match_edid with the pattern
            if __match_edid "$edid_data" "$edid_pattern"; then
                log_inf "Pattern [$edid_pattern] matched in [$drm_device]"
                # Call callback script
                __run_callback "${callback[@]}"
            fi
        fi
    done
}

monitor_detector_check_presence "$1" "${@:2}"

