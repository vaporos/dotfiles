
ps1color()
{
  echo "$1" | cksum | awk '{gsub("^",".",$1);printf "%d",256*$1}'
}

function prompt
{
  local WHITEBRIGHT='\[\e[1;37m\]'
  local NORM='\[\e[0;0m\]'
  local COLOR=

  case "$1" in
      starship)
          if [ -x /opt/homebrew/bin/starship ]; then
              eval "$(/opt/homebrew/bin/starship init bash)"
          fi
          return
          ;;
      starship-lite)
          PS1="\$(starship prompt)"
          return
          ;;
  esac

  case "$1" in
    red|root)
      COLOR='\[\e[1;31m\]'
      ;;
    green)
      COLOR='\[\e[1;32m\]'
      ;;
    yellow)
      COLOR='\[\e[1;33m\]'
      ;;
    blue)
      COLOR='\[\e[1;34m\]'
      ;;
    purple|pink)
      COLOR='\[\e[1;35m\]'
      ;;
    cyan)
      COLOR='\[\e[1;36m\]'
      ;;
    default|host)
      COLOR='\[\e[38;5;$(ps1color $HOSTNAME)m\]'
      ;;
    *)
      WHITEBRIGHT=
      NORM=
      COLOR=
  esac

  type __git_ps1 > /dev/null 2>&1
  if [ $? == 0 ]; then
      PS1=" [$COLOR\$?$NORM] ($COLOR\w$NORM) \$(__git_ps1 \"($WHITEBRIGHT%s$NORM)\")\n$WHITEBRIGHT\u$NORM@$COLOR\h$NORM "
  else
      PS1=" [$WHITEBRIGHT\!$NORM:$COLOR\$?$NORM] ($COLOR\w$NORM)\n$WHITEBRIGHT\u$NORM@$COLOR\h$NORM "
  fi

  if [ "$1" == root ]; then
    PS1="$PS1# "
  else
    PS1="$PS1% "
  fi
}

complete -W "red green yellow blue purple pink cyan root host default" prompt
