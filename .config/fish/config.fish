set -gx EDITOR nvim
set -gx PAGER 'less --use-color -DdR -DuG --incsearch'
set -gx CMAKE_GENERATOR 'Unix Makefiles'
set -g new_line_before_prompt false

bind -M insert \v kill-line
bind -M insert \b backward-kill-word
bind -M insert \e\[3\;5\~ kill-word
bind -M insert \cF accept-autosuggestion

function fish_prompt
        if not set -q last_clear
                set -g last_clear false
        end

        if test $history[1] = 'clear'
                if test $last_clear = false
                        set -g last_clear true
                        set -g new_line_before_prompt false
                end
        else
                set -g last_clear false
        end

        if not set -q $TERMINAL
                set -gx TERMINAL (term_name)
        end

        if test $TERMINAL = 'konsole' -o $TERMINAL = 'dolphin' -o $TERMINAL = 'alacritty'
                set -gx print_new_line_before_prompt true
                ~/.config/fish/prompt_theme/modern_prompt.fish $new_line_before_prompt
        else
                set -gx print_new_line_before_prompt false
                ~/.config/fish/prompt_theme/two_lines_prompt.fish $new_line_before_prompt
        end

        set -g new_line_before_prompt true
end

function fish_greeting
        set -l term (term_name)

        if test $term != 'login'
                starship init fish | source

                if test $term = 'emacs'
                        set -gx EDITOR nano
                        set -gx GIT_EDITOR nano
                else
                        set GIT_EDITOR nvim
                end
        end

        echo -n ""
end
