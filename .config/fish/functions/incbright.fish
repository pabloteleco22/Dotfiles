function incbright
	set -l dir /sys/class/backlight/intel_backlight
	set -l br (cat $dir/actual_brightness)
	set -l step 10

	modbright (math $br+$step) 2> /dev/null

	#set -l mon (xrandr --current | grep -e "\bconnected" | cut -d" " -f1)
	#set -l br (xrandr --verbose --current | grep ^$mon -A5 | tail -1 | cut -d' ' -f2)
	#if test (math $br+0.1) -le 1
		#xrandr --output $mon --brightness (math $br+0.1)
	#end
end
