set_global_assignment -entity "IPPLL2" -library "lib_IPPLL2" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "IPPLL2" -library "lib_IPPLL2" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "IPPLL2" -library "lib_IPPLL2" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_IPPLL2" -name SPD_FILE [file join $::quartus(sip_path) "IPPLL2.spd"]

set_global_assignment -library "lib_IPPLL2" -name MISC_FILE [file join $::quartus(sip_path) "IPPLL2_sim/IPPLL2.vo"]
