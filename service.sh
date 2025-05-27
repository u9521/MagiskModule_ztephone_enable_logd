#这个脚本将会在 late_start 服务模式下运行
# 获取模块的基本目录路径
MODDIR=${0%/*}

# 请注意：
# - 避免使用可能阻塞或显著延迟启动过程的命令。
# - 确保此脚本启动的任何后台任务都得到妥善管理，以避免资源泄漏。

# 有关更多信息，请参阅 KernelSU 文档中的启动脚本部分。
# 开机后再触发一下服务防止失效
start triggerlogtag
resetprop -w sys.boot_completed 0
start triggerlogtag
