#!/bin/bash

# Bash Command Prompt
USER='\[\033[01;32m\]\u '
HOST='\[\033[02;36m\]\h ' # $HOSTNAME
getRepoBranch () { repo branch ; }
getGitRoot () { git root ; }
getGitBranch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }
TIME='\[\033[01;35m\]\t '
BRANCH='\[\033[01;36m\]$(getGitBranch)\[\033[00;33m\]-$(getGitRoot) '
LOCATION='\[\033[01;34m\]`pwd | sed "s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1_\2#g"`\[\033[00m\]\n=> '
#LOCATION=' \[\033[01;34m\]`pwd \[\033[00m\]\n=> '
PS1=$TIME$USER$BRANCH$LOCATION

# Aliases
alias androidStudio='/home/ashrif/android-studio/bin/studio.sh'
alias uiautomatorViewer='/home/ashrif/Android/Sdk/tools/bin/uiautomatorviewer'
alias bbtoolauth='/opt/BDT/bdt.py --run "BB Tool Auth"' # needs to be installed
alias reposynclite='repo sync -j8 --no-tags --no-clone-bundle --current-branch'
alias reposynclitetrace='repo --trace sync -j8 --no-tags --no-clone-bundle --current-branch'

# Git prompt support
source ~/.git-prompt.sh
source ~/.git-completion.bash


# Function: Start Android Studio
startAndroidStudio () { ~/android-studio/bin/studio.sh ; }

# Function: Set title for Terminal Tab
setTerminalTitle(){
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

# Function: Source .bashrc
sourceBashrc () { source ~/.bashrc ; }

# Function: Set Device to DO
setDO () { adb shell dpm set-device-owner com.blackberry.afwsamples.testdpc/.DeviceAdminReceiver ;}

# Function: Get Deivice Policy Info
getDevicePolicyInfo () { adb shell dumpsys device_policy ; }

# Function: Source Build/env
sourceBuildEnvSetup () { source build/envsetup.sh ; }

# Function: get android Device Boot Time
getDeviceBootTime () {
  time (
  adb reboot;
  adb wait-for-device;
  while [ $(adb shell getprop | grep -c bootcom) -eq 0 ];
  do sleep 0.1;
  done;
  echo DONE;
  );
  }

#
getPackagesList () { adb shell pm list packages -f ; }

#
turnOffKB () {
  adb root;
  adb remount;
  adb shell;
  echo 1 > /sys/devices/touch_keypad/turn_off;
  }

#
deleteTestDpcApp () {
  adb root;
  adb remount;
  adb shell rm -rf /system/app/TestDpc/TestDpc.apk
  }


# Setting up os enviroment varibles (/etc/environment)
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
PATH=$PATH:$JAVA_HOME/bin
export ANDROID_HOME=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/tools/bin
PATH=$PATH:$HOME/.repoTool/repo
PATH=$PATH:$HOME/.bin

# Source os environment
source /etc/environment

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="~/.sdkman"
[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"
