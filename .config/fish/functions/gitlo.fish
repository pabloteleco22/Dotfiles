function gitlo --wraps='git log --graph --all --oneline' --description 'alias gitlo git log --graph --all --oneline'
  git log --graph --all --oneline $argv; 
end
