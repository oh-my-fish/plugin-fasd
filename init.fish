# Detect fasd
if type -q fasd
  # Hook into fish preexec event
  function __fasd_run -e fish_preexec
    command fasd --proc (command fasd --sanitize "$argv" | tr -s ' ' \n) > "/dev/null" 2>&1 &
  end
else
  echo "🍒  Please install 'fasd' first!"
end
