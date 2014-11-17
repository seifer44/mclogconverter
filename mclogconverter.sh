#!/bin/bash
#
#  https://github.com/seifer44/mclogconverter
#
##############################################################
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################
#
##############################################################
######    Please refer to the README for additional     ######
######  information in regard to running this script.   ######
######                                                  ######
######  Edit the following to the appropriate log file  ######
######     to read from and your output log folder.     ######
##############################################################

logfile=server.log
logfolder=logs

##############################################################
###############DO NOT EDIT. CORE FUNCTIONALITY ###############
##############################################################
linenum=`wc -l $logfile | cut -f1 -d " "`
i=1
ignoredline=0

echo "Beginning conversion. $logfile will not be modified."

if [ ! -d $logfolder ]
then
        echo "Directory $logfolder not found. Created the directory."
        mkdir $logfolder
fi

echo -n "Converting"

ignoredlinesarray=()

while [ $i -le $linenum ]
do
        logarray=(`sed -n "$i p" $logfile | sed 's/\[/[Server thread\//'`)

        if [ ${logarray} > /dev/null ]
        then
                if [[ ${logarray[0]} == *-*-*  ]]
                then
                        echo "[${logarray[1]}] ${logarray[2]} ${logarray[3]}: ${logarray[@]:4}" >> "$logfolder/${logarray[0]}-1.log"
                        echo -n "."
                else
                        echo -n " Found line that didn't begin with a date. Ignoring."
                        let ignoredline=$ignoredline+1
                        ignoredlinesarray+=($i)
                fi
        fi
        let i=$i+1
#       read
done

echo -e "\n\n*******************End of file.*******************"
echo -e "\ngzipping logs."
gzip $logfolder/*.log

echo "Done!"

if [ $ignoredline -gt 0 ]
then
        echo -e "\nHad $ignoredline lines ignored from conversion. This is due to a date not proceeding the line, thus not knowing which log to append to."
        echo "Ignored lines: ${ignoredlinesarray[@]}"
fi
