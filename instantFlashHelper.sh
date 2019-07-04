#!/bin/bash

#########################################################################################
#    A Script that automatically mv all the .bin you download to the specified dest     #
#    Copyright (C) 2019  Antoine Braut                                                  #
#                                                                                       #
#    This program is free software: you can redistribute it and/or modify               #
#    it under the terms of the GNU General Public License as published by               #
#    the Free Software Foundation, either version 3 of the License, or                  #
#    (at your option) any later version.                                                #
#                                                                                       #
#    This program is distributed in the hope that it will be useful,                    #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of                     #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                      #
#    GNU General Public License for more details.                                       #
#                                                                                       #
#    You should have received a copy of the GNU General Public License                  #
#    along with this program. If not, see <https://www.gnu.org/licenses/>.              #
#                                                                                       #
#    Contact : Antoine.braut@gmail.com                                                  #
#                                                                                       #
#########################################################################################

tempDir="/tmp/instantflashhelper"
mkdir -p ${tempDir}

trap do_cleanup_and_quit EXIT


# Default values
DL_PATH=${HOME}/Downloads
LAST_LIST=${tempDir}/last.list
CUR_LIST=${tempDir}/cur.list
COMMAND="mv"
COMMAND_STRING="Moving"

# Display help and usage
display_help ()
{
	echo "Usage : instantflashhelper [OPTION ...] target_directory

Option :

	-h | --help			Display this message and quit
	-v | --version	Display script version and quit
	-c | --copy			Copy the new bin instead of moving it
	-s | --source		Change the source directory for the new file

Example : instantflashhelper -c --source ~/Desktop/some_directory /media/user/card_directory # Copy all the new .bin files that appear in ~/Desktop/some_directory to /media/user/card_directory"
}
# Display version
display_version ()
{
	echo "instantflashhelper -- v1.0 (alpha release)"
}
# Remove temp folder and say goodbye
do_cleanup_and_quit ()
{
	rm -rf ${tempDir}
	#echo -e "\b\bGoodbye. Have a good day !"
}

# Parse options
while getopts ":hvsc-:*:" opt ; do
	case $opt in
		h )
			display_help
			exit 0 ;;
		v )
			display_version
			exit 0 ;;
		s )
			DL_PATH=${!OPTIND}
			shift 1;;
		c )
			COMMAND="cp"
			COMMAND_STRING="Copying";;
		- ) case $OPTARG in
			help )
				display_help
				exit 0 ;;
			version )
				display_version
				exit 0;;
			source )
				DL_PATH=${!OPTIND}
				shift 1;;
			copy )
			COMMAND="cp"
			COMMAND_STRING="Copying";;
			* )
				echo "Unrecognized option : --$OPTARG"
				display_help
				exit 1 ;;
			esac ;;
		* )
			echo Unrecognized option : $opt
			display_help
			exit 1 ;;
	esac
done
shift $(($OPTIND-1))

CARD_PATH=$1

echo "Starting instantflashhelper.
Source directory : ${DL_PATH}
Destination directory : ${CARD_PATH}"

ls ${DL_PATH} > ${LAST_LIST}

# MainLoop
while true; do

	ls ${DL_PATH} > ${CUR_LIST}

	NEW_BIN=$(echo $(diff ${LAST_LIST} ${CUR_LIST} | grep '^>.*\.bin$') | sed -e 's/> *//')

	if [ ! -z ${NEW_BIN} ];then
		 echo ${COMMAND_STRING} ${NEW_BIN} to ${CARD_PATH}.
		 ${COMMAND} ${DL_PATH}/${NEW_BIN}  ${CARD_PATH}
	fi

	ls ${DL_PATH} > ${LAST_LIST}

	sleep 2
done
