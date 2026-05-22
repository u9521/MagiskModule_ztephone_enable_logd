MODDIR=${0%/*}

# reset to disable
resetprop -n persist.sys.ztelog.enable 0
resetprop log.tag.RequestManager S
resetprop log.tag.APM_AudioPolicyManager S