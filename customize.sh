print_sepline() {
  local len bar
  len=50
  bar=$(printf "%${len}s" | tr ' ' '*')
  ui_print "$bar"
}

SKIPUNZIP=0

rm -f $MODPATH/LICENSE
# 打印信息到控制台

MODDESC=`grep_prop description $TMPDIR/module.prop`
MODDVER=`grep_prop version $TMPDIR/module.prop`
MODDVERCODE=`grep_prop versionCode $TMPDIR/module.prop`
ui_print "- 开始安装 $MODNAME"
ui_print "- 模块路径: $MODPATH"
ui_print "- 模块版本: $MODDVER"
ui_print "- 模块版本号: $MODDVERCODE"
ui_print "- 设备架构: $ARCH"
ui_print "- Android API 版本: $API"

if [ "$KSU" = "true" ]; then
  ui_print "- kernelSU version: $KSU_VER ($KSU_VER_CODE)"
  if [ "$(which magisk)" ]; then
    print_title "! Multiple root implementation is NOT supported !" "! Please uninstall Magisk or KernelSU !"
    abort "Unsupport Multiple root implementation"
  fi

elif [ "$APATCH" = "true" ]; then
  APATCH_VER=$(cat "/data/adb/ap/version")
  ui_print "- APatch version: $APATCH_VER"
  ui_print "- KERNEL_VERSION: $KERNEL_VERSION"
  ui_print "- KERNELPATCH_VERSION: $KERNELPATCH_VERSION"
  if [ "$(which magisk)" ]; then
    print_title "! Multiple root implementation is NOT supported !" "! Please uninstall Magisk or APatch !"
    abort "Unsupport Multiple root implementation"
  fi

else
  ui_print "- Magisk version: $MAGISK_VER ($MAGISK_VER_CODE)"
    if [ -f $MODPATH/boot-completed.sh ]; then
      ui_print "[Warning] boot-completed.sh only works for KernelSU and Apatch, this script will be ignored in Magisk."
    fi
fi

print_sepline
ui_print "$MODDESC"
print_sepline

# 设置文件权限
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm_recursive $MODPATH/system_ext/bin 0 2000 0751 0755
set_perm $MODPATH/system_ext/bin/triggerlogtag.sh 0 2000 0755 u:object_r:getlog_exec:s0
ui_print "- 安装完成"
