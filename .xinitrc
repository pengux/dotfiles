xrdb -merge ~/.Xresources

if [ -x /usr/bin/autocutsel ]; then
	# this will keep the clipboard in sync
	# with the primary buffer
	autocutsel -selection CLIPBOARD -fork

	# this will keep the primary in sync
	# with the clipboard buffer
	autocutsel -selection PRIMARY -fork
fi

# Set key repeat rate
xset r rate 200 25

exec bspwm