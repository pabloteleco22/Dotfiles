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

set_color -b red
printf '%s' \uf31a
echo -n ' '$USER@$hostname
set_color red -b yellow
printf '%s  ' \ue0c0
set_color normal -b yellow
printf '%s  ' \uf07c
echo -n (prompt_pwd)
if test $local_branch
	set_color yellow -b bryellow
	printf '%s  ' \ue0c0
	set_color brmagenta
	printf '%s ' \ue725
	echo -n $local_branch
	set_color bryellow -b normal
	printf '%s \n' \ue0c0
else
	set_color yellow -b normal
	printf '%s \n' \ue0c0
end
set_color $user_color
printf '%s ' \uf054
set_color normal

