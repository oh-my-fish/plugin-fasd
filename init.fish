function init --on-event init_fasd
  # Detect fasd
  if not type -q fasd
    echo "🍒  Please install 'fasd' first!"
    return
  end

  # Hook into fish preexec event
  function __fasd_run -e fish_preexec
    command fasd --proc (command fasd --sanitize "$argv") > "/dev/null" 2>&1 &
  end

  function a; command fasd -a $argv; end
  function s; command fasd -si $argv; end
  function d; command fasd -d $argv; end
  function f; command fasd -f $argv; end
  function sd; command fasd -sid $argv; end
  function sf; command fasd -sif $argv; end
  function z; fasd_cd -d $argv; end
  function zz; fasd_cd -di $argv; end
end
