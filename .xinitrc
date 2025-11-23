/usr/bin/xremap --watch=config --watch=device --device "SteelSeries SteelSeries Apex 3 TKL" /home/sidney/.config/xremap/config.yml &

#GTK_CSD=1
#exec dbus-launch --exit-with-session xfce4-session
exec dbus-run-session xfce4-session

#XSESSION=openbox
#exec dbus-run-session openbox-session
