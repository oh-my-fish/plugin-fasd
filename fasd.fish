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
    command fasd --proc (command fasd --sanitize "$argv") > "/dev/null" 2>&1
  end

  function fasd_cd -d 'Function to execute built-in cd'
    # if no $argv, identical with `fasd`
    set -l N (count $argv ^ /dev/null)
    if [ "$N" -le 1 ]
      command fasd "$argv"
    else
      [ -z "$ret" ]; and return
      [ -d "$ret" ]; and cd "$ret"; or printf "%s\n" $ret
      set -l ret (command fasd -e 'printf %s' $argv)
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
