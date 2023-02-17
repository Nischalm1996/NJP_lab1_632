set_global_assignment -entity "IPPLL3" -library "lib_IPPLL3" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "IPPLL3" -library "lib_IPPLL3" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "IPPLL3" -library "lib_IPPLL3" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_IPPLL3" -name SPD_FILE [file join $::quartus(sip_path) "IPPLL3.spd"]

set_global_assignment -library "lib_IPPLL3" -name MISC_FILE [file join $::quartus(sip_path) "IPPLL3_sim/IPPLL3.vo"]
