#!/bin/bash

EXEC="radiant.bin"
FOLD="$HOME/.gtkradiant/"

VERS="rpm_version"

if [ ! -f $FOLD$EXEC ]; then
	zenity --question --text='This is the first time you launch GtkRadiant.
Now there will be some configurations in your home: this may take a while, depending on your CPU. Proceed?'
	if [[ $? == 0 ]]; then
		cp -Rf /usr/share/gtkradiant/ $HOME/.gtkradiant-src/
		cd $HOME/.gtkradiant-src/
		scons target=radiant,q3map2 config=release
		mv install/ $HOME/.gtkradiant/
		cd $HOME && rm -rf $HOME/.gtkradiant-src/
	else
		exit 0
	fi
fi


VERS1=`cat $FOLD$VERS`
VERS2=`cat /usr/share/gtkradiant/install/$VERS`

if [[ $VERS2 > $VERS1 ]]; then
	zenity --question --text='There is an update available for GtkRadiant in your home, update it to the latest version?'
	if [[ $? == 0 ]]; then
		rm -rf $FOLD
		cp -Rf /usr/share/gtkradiant/ $HOME/.gtkradiant-src/
		cd $HOME/.gtkradiant-src/
		scons target=radiant,q3map2 config=release
		mv install/ $HOME/.gtkradiant/
		cd $HOME && rm -rf $HOME/.gtkradiant-src/

	fi
fi

$FOLD$EXEC
