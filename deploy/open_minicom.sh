
for tty in $(ls /dev/ttyUSB*); do
	echo ${tty}
	konsole --new-tab -e minicom -b 115200 -D $tty &
done

