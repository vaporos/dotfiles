
function set_path
{
  local IFS
  local MY_PATH

  PATH=""

  MY_PATH=$MY_PATH:/bin
  MY_PATH=$MY_PATH:/sbin
  MY_PATH=$MY_PATH:/usr/bin
  MY_PATH=$MY_PATH:/usr/sbin
  MY_PATH=$MY_PATH:/usr/games
  MY_PATH=$MY_PATH:/usr/X11R6/bin
  MY_PATH=$MY_PATH:/usr/openwin/bin
  MY_PATH=$MY_PATH:/usr/local/bin
  MY_PATH=$MY_PATH:/usr/local/sbin
  MY_PATH=$MY_PATH:/usr/ucb
  MY_PATH=$MY_PATH:/usr/ccs/bin
  MY_PATH=$MY_PATH:/usr/ccs/bin
  MY_PATH=$MY_PATH:/usr/ucb
  MY_PATH=$MY_PATH:/cygdrive/c/Windows/System32
  MY_PATH=$MY_PATH:/cygdrive/c/Windows
  MY_PATH=$MY_PATH:$HOME/bin

  if [ "$MY_PATH_PREPEND" != "" ]; then
    MY_PATH=$MY_PATH_PREPEND:$MY_PATH
  fi
  if [ "$MY_PATH_APPEND" != "" ]; then
    MY_PATH=$MY_PATH:$MY_PATH_APPEND
  fi

  IFS=:
  for p in $MY_PATH
  do
    if [ -d $p ]; then
      if [ "$PATH" == "" ]; then
        PATH=$p
      else
        PATH=$PATH':'$p  
      fi
    fi
  done
  unset IFS

  export PATH
}

function path_init
{
  PATH="/bin:/sbin:/usr/bin:/usr/sbin"
  MY_PATH_PREPEND=""
  MY_PATH_APPEND=""
  export PATH MY_PATH_PREPEND MY_PATH_APPEND
}

function path_prepend
{
  if [ "$MY_PATH_PREPEND" == "" ]; then
    MY_PATH_PREPEND="$1"
  else
    MY_PATH_PREPEND="$1:$MY_PATH_PREPEND"
  fi
  export MY_PATH_PREPEND
}

function path_append
{
  if [ "$MY_PATH_APPEND" == "" ]; then
    MY_PATH_APPEND="$1"
  else
    MY_PATH_APPEND="$MY_PATH_APPEND:$1"
  fi
  export MY_PATH_APPEND
}
