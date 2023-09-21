function declutter --wraps='pgrep unclutter | kill -KILL' --wraps='kill -KILL(pgrep unclutter)' --wraps='kill -KILL (pgrep unclutter)' --description 'alias declutter kill -KILL (pgrep unclutter)'
  kill -KILL (pgrep unclutter) $argv; 
end
