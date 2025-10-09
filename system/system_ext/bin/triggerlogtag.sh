#!/system/bin/sh

# 模块安装后不要直接修改此文件，不然你很可能遇上selinux问题导致不生效
# 该文件安全上下文是 u:object_r:getlog_exec:s0

if [ "$(getprop persist.sys.stc)" = "true" ]; then
    setprop log.tag ""
    exit 0
fi

if [ "x$(getprop persist.sys.ztelog.enable)" = "x1" ]; then
    setprop log.tag ""
    setprop log.tag.InputMethodManagerService D
    setprop log.tag.DoubleApp V
    setprop log.tag.ZteDeviceIdentify D
    setprop log.tag.AppWidget D
    setprop log.tag.UsageStatsService D
    setprop log.tag.zteSecurityImeHelp D
    setprop log.tag.ImeFocusController D
    setprop log.tag.InputMethodManager D
    setprop log.tag.ViewRootImpl D
    setprop log.tag.DefaultImeVisibilityApplier D
    setprop log.tag.APM_AudioPolicyManager D
    setprop log.tag.stats_log I
    setprop log.tag.Watchdog I
    setprop persist.log.tag.Telecom D
    setprop persist.log.tag.AndroidRuntime D
    setprop persist.log.tag.LIB_DEBUG D
    setprop persist.log.tag.RenderEngine I
    setprop log.tag.qdgralloc E
    setprop log.tag.CV E
    setprop log.tag.IMGTXRFILTER E

else
    # 去除logtag设置
    # setprop log.tag S
    # setprop log.tag.InputMethodManagerService S
    # setprop log.tag.DoubleApp S
    # setprop log.tag.ZteDeviceIdentify S
    # setprop log.tag.AppWidget S
    # setprop log.tag.UsageStatsService S
    # setprop log.tag.zteSecurityImeHelp S
    # setprop log.tag.ImeFocusController S
    # setprop log.tag.InputMethodManager S
    # setprop log.tag.ViewRootImpl S
    # setprop log.tag.DefaultImeVisibilityApplier S
    setprop log.tag.APM_AudioPolicyManager S
    # setprop log.tag.stats_log S
    # setprop persist.log.tag.Telecom S
    # setprop persist.log.tag.RenderEngine S
    # setprop log.tag.qdgralloc S
    # setprop log.tag.CV S
    # setprop log.tag.IMGTXRFILTER S
fi


