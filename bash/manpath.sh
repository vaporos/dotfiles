
function set_manpath
{
  local IFS
  local MY_MANPATH

  MANPATH=""

  MY_MANPATH=$MY_MANPATH:/usr/man
  MY_MANPATH=$MY_MANPATH:/usr/share/man
  MY_MANPATH=$MY_MANPATH:/usr/X11R6/man
  MY_MANPATH=$MY_MANPATH:/usr/local/man

  if [ "$MY_MANPATH_PREPEND" != "" ]; then
    MY_MANPATH=$MY_MANPATH_PREPEND:$MY_MANPATH
  fi
  if [ "$MY_MANPATH_APPEND" != "" ]; then
    MY_MANPATH=$MY_MANPATH:$MY_MANPATH_APPEND
  fi

  IFS=:
  for p in $MY_MANPATH
  do
    if [ -d $p ]; then
      if [ "$MANPATH" == "" ]; then
        MANPATH=$p 
      else
        MANPATH=$MANPATH:$p 
      fi
    fi
  done
  unset IFS

  export MANPATH
}

function manpath_init
{
  MANPATH="/usr/man:/usr/share/man:/usr/X11R6/man"
  MY_MANPATH_PREPEND=""
  MY_MANPATH_APPEND=""
  export MANPATH MY_MANPATH_PREPEND MY_MANPATH_APPEND
}

function manpath_prepend
{
  if [ "$MY_MANPATH_PREPEND" == "" ]; then
    MY_MANPATH_PREPEND="$1"
  else
    MY_MANPATH_PREPEND="$1:$MY_MANPATH_PREPEND"
  fi
  export MY_MANPATH_PREPEND
}

function manpath_append
{
  if [ "$MY_MANPATH_APPEND" == "" ]; then
    MY_MANPATH_APPEND="$1"
  else
    MY_MANPATH_APPEND="$MY_MANPATH_APPEND:$1"
  fi
  export MY_MANPATH_APPEND
}

