#
# Add a little automation to using projectors or dual monitors
# 

if [ $# -lt 1 ] ; then
	echo Usage: $1 [command]
	echo 
	echo Commands listed below.
	echo
	echo Basic Setup:
	echo 	mirror
	echo
	echo Dual Monitors:
	echo	dual-left
	echo	dual-right
	echo	dual-above
	echo	dual-below
	exit
fi

xrandr --output VGA-0 --off

case $1 in
	"mirror")
		xrandr --output VGA-0 --auto
		echo Mirroring setup;;
	"dual-left")
		xrandr --output VGA-0 --left-of LVDS --auto
		echo Dualing left setup;;
	"dual-right")
		xrandr --output VGA-0 --right-of LVDS --auto
		echo Dualing right setup;;
	"dual-above")
		xrandr --output VGA-0 --above LVDS --auto
		echo Dualing above setup;;
	"dual-below")
		xrandr --output VGA-0 --below LVDS --auto
		echo Dualing below setup;;
	"off")
		xrandr --output LVDS --auto
		echo ;;
	*)
		echo Option not supported;;
esac

# Set the beep off again, just in case
xset b off
