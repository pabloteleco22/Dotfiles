function modbright
	set -l dir /sys/class/backlight/intel_backlight
	set -l max (cat $dir/max_brightness)

	if test $max -ge $argv[1] && test 0 -lt $argv[1]
		echo -n $argv[1] > /sys/class/backlight/intel_backlight/brightness
	else
		echo "Uso:" >&2
		echo "modbright <1-$max>" >&2
		
		return 1
	end
end
