function fish_right_prompt
	if set -q VIRTUAL_ENV
		echo -n -s "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
	end
end
