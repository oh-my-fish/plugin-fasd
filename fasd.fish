function init --on-event init_fasd
  # Detect fasd
  if not available fasd
    echo "🍒  Please install 'fasd' first!"
    return
  end

  #
  # Fish hooks
  #
  function -e fish_preexec _run_fasd
    fasd --proc (fasd --sanitize "$argv") > "/dev/null" 2>&1
  end

  function fasd_cd -d 'Function to execute built-in cd'
    # if no $argv, identical with `fasd`
    set -l N (count $argv ^ /dev/null)
    if [ "$N" -le 1 ]
      fasd "$argv"
    else
      set -l ret (fasd -e 'printf %s' $argv)
      [ -z "$ret" ]; and return
      [ -d "$ret" ]; and cd "$ret"; or printf "%s\n" $ret
    end
  end

  alias a='fasd -a'
  alias s='fasd -si'
  alias sd='fasd -sid'
  alias sf='fasd -sif'
  alias d='fasd -d'
  alias f='fasd -f'
  alias z='fasd_cd -d'
  alias zz='fasd_cd -di'

  # Useful aliases
  alias v='f -t -e vim -b viminfo'
end
