function init --on-event init_fasd
  # Detect fasd
  if not available fasd
    echo "🍒  Please install 'fasd' first!"
    return
  end

  # Hook into fish preexec event
  function __fasd_run -e fish_preexec
    command fasd --proc (command fasd --sanitize "$argv") > "/dev/null" 2>&1
  end

  function fasd_cd -d 'Function to execute built-in cd'
    # if no $argv, identical with `fasd`
    if test (count $argv) -le 1
      command fasd "$argv"
    else
      set -l ret (command fasd -e 'printf %s' $argv)
      test -z "$ret";
        and return
      test -d "$ret";
        and cd "$ret";
        or printf "%s\n" $ret
    end
  end

  alias a='command fasd -a'
  alias s='command fasd -si'
  alias sd='command fasd -sid'
  alias sf='command fasd -sif'
  alias d='command fasd -d'
  alias f='command fasd -f'
  alias z='fasd_cd -d'
  alias zz='fasd_cd -di'

  # Useful aliases
  alias v='f -t -e vim -b viminfo'
end
