function ls --wraps=lsd --wraps='lsd --config-file ~/.config/lsd/lsd.config' --wraps='lsd --config-file ~/.config/lsd/lsd.conf' --description 'alias ls lsd --config-file ~/.config/lsd/lsd.conf'
lsd --config-file ~/.config/lsd/lsd.conf $argv;
end
