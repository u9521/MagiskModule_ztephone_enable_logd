# 在ZTE设备上启用logd日志输出

  在myOS，redmagicOS中，`log.tag`默认设置等级的是`S`，也就是不输出日志，这给调试工作带来了一些麻烦。

## 打开系统自带的日志

  你可以通过ADB手动`setprop log.tag ""`，但是每次开机都要重新设置，比较麻烦。
  
  也可以通过**用户帮助** -> **底栏用户反馈** -> **右上角设置** -> **打开日志常开** 

  没有**安装用户帮助**的话也可以发送广播或`setprop`实现开启全部日志

  打开全部日志
  ```
  am broadcast -a com.zte.userguide.KEEP_LOG_ALWAYS_ON --ei keepLogOn 1
  # 或者,这样设置临时生效
  setprop persist.sys.ztelog.enable 1
  ```
  关闭全部日志
  ```
  am broadcast -a com.zte.userguide.KEEP_LOG_ALWAYS_ON --ei keepLogOn 0
  # 或者,这样设置临时生效
  setprop persist.sys.ztelog.enable 0
  ```
  但是，只要用了这个方法，系统就会启动logcat向`/data/local/vendor_logs`写日志，即使关闭了也不会清除文件（用户反馈中清理所有日志也不会清除文件）
  ```
#/system_ext/bin/getlogtofile
...
CACHEDIR=/cache
DATADIR=/data
SYSDIR=/data/local
LOGDIR=$SYSDIR/vendor_logs
LOGS_DIR=vendor_logs
...
function logcat_to_file()
{
	....
    my_logcat -b crash -f $LOGDIR/logcat/logcat_crash.txt -r5120 -n8 -v threadtime AndroidRuntime:D DEBUG:D LIB_DEBUG:D *:S &
    my_logcat -b system -f $LOGDIR/logcat/logcat_system.txt -r20480 -n16 -v threadtime *:D PowerTracker:S &
    ....
    debug "logcat_to_file end"
	....
}
  ```

## 通过模块打开日志

大多数时候，我们不需要一些来自系统或内核的日志，于是可以通过magisk模块来阻止系统在开机的时候设置logd日志tag

直接从[release](https://github.com/u9521/MagiskModule_ztephone_enable_logd/releases)下载本模块，然后在管理器(magisk,Kernelsu,apatch)里面安装，重启后日志就回来了，而且后台不会有logcat占用，也不会写日志到磁盘上


注意，目前有下列日志Tag等级被设置成S，你应该避免使用这些日志Tag

只拦截非system_server和非应用的日志

- RequestManager
- APM_AudioPolicyManager

> [!WARNING]
> 启用了模块后，不推荐手动操作打开系统自带的日志


> [!IMPORTANT]
> 在 `v1.0.2` 版本中，添加了免挂载的支持。在模块根目录添加`skip_mount`文件即可跳过挂载，模块挂载文件的作用是阻止开机后意外操作导致触发`triggerlogtag`服务。