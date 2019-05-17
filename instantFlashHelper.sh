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
# Contact : Antoine.braut@gmail.com                                                     #
#                                                                                       #
#########################################################################################

mkdir -p .temp

CARD_PATH=$1
DL_PATH=${HOME}/Downloads
LAST_LIST=./.temp/last.list
CUR_LIST=./.temp/cur.list

ls ${DL_PATH} > ${LAST_LIST}

while true; do

	ls ${DL_PATH} > ${CUR_LIST}
	
	NEW_BIN=$(echo $(diff ${LAST_LIST} ${CUR_LIST} | grep '^>.*\.bin$') | sed -e 's/> *//')

	[  -z ${NEW_BIN} ] || mv ${DL_PATH}/${NEW_BIN}  ${CARD_PATH}

	ls ${DL_PATH} > ${LAST_LIST}

	sleep 2
done
