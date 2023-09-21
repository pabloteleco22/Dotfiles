#!/usr/bin/fish

set -l user_char '>'
set -l user_char_color '\e[0m'
set -l new_line_before_prompt $argv[1]

if test (whoami) = 'root'
    set user_char '#'
    set user_char_color '\e[31m'
end

if set -q print_new_line_before_prompt
    if $print_new_line_before_prompt && $new_line_before_prompt
        echo ''
    end
else
    set -gx print_new_line_before_prompt false
end

set -l local_branch (git branch --show-current 2> /dev/null)

printf '\e[31m┌──(\e[1;32m%s\e[0;35m@\e[1;32m%s\e[0;31m)─[\e[1;34m%s\e[0;31m' $USER $hostname (prompt_pwd)\e[0;31m]
if test $local_branch
    printf "─{\e[93m\uf126\e[1;93m %s\e[0;31m}" $local_branch
end

echo -e "\n└─$user_char_color$user_char\\033[0m "
