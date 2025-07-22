set -gx EDITOR nvim
set -gx PAGER 'less --use-color -DdR -DuG --incsearch'
set -gx MANROFFOPT '-P -c'
set -gx CMAKE_GENERATOR 'Unix Makefiles'

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_key_bindings fish_vi_key_bindings
    bind -M insert \v kill-line
    bind -M insert \b backward-kill-word
    bind -M insert \e\[3\;5\~ kill-word
    bind -M insert \cF accept-autosuggestion
end

function fish_greeting
	
end

pyenv init - fish | source

starship init fish | source
