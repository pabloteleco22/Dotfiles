function gitl --wraps='git log --all --graph' --description 'alias gitl git log --all --graph'
  git log --all --graph $argv; 
end
