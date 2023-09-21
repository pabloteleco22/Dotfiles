#!/usr/bin/fish

set -l new_line_before_prompt $argv[1]

if set -q print_new_line_before_prompt
        if $print_new_line_before_prompt && $new_line_before_prompt
                echo ''
        end
else
        set -gx print_new_line_before_prompt false
end

if test $USER = root
        set -f user_color red
else
        set -f user_color blue
end

set -l local_branch (git branch --show-current 2> /dev/null)

set -l separator \ue0b4

set_color -b brmagenta
printf '%s' \uf31a
echo -n ' '$USER@$hostname' '
set_color brmagenta -b blue
printf '%s  ' $separator
set_color black -b blue
printf '%s  ' \uf07c
echo -n (prompt_pwd)' '
if test $local_branch
        set_color blue -b bryellow
        printf '%s  ' $separator
        set_color black -b bryellow
        printf '%s ' \ue725
        echo -n $local_branch' '
        set_color bryellow -b normal
        printf '%s \n' $separator
else
        set_color blue -b normal
        printf '%s \n' $separator
end
set_color $user_color
printf '%s ' \uf054
set_color normal
