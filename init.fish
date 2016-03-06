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
end
