function where () {
  return_value=1

  if [ $# != 1 ]; then
    echo "Usage: where <command>"
    return -1
  fi

  echo $1 | grep = 2>&1 > /dev/null
  if [ $? == 1 ]; then
    alias | grep "^alias $1=" 2>&1 > /dev/null
    if [ $? == 0 ]; then
      echo $1 is aliased to `alias $1 | awk -F'=' '{print $2}'`
      return_value=0
    fi
  fi

  for i in `echo $PATH | sed -e 's/:/ /g'`; do
    if [ -f $i/$1 ] && [ -e $i/$1 ]; then
      echo $i/$1
      return_value=0
    fi
  done

  return $return_value
}

function which () {
  local IFS
  local alias_cmd

  if [ $# != 1 ]; then
    echo "Usage: which <command>"
    return -1
  fi

  alias_cmd=$(alias "$1" 2>/dev/null)
  if [ -n "$alias_cmd" ]; then
    echo $1 is aliased to ${alias_cmd#*=}
    return 0
  fi

  IFS=:
  for i in $PATH; do
    if [ -f $i/$1 ] && [ -e $i/$1 ]; then
      echo $i/$1
      return 0
    fi
  done
  unset IFS

  echo "$1: Command not found."
  return 1
}
