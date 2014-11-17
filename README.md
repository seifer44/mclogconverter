mclogconverter
==============

This tool was created to convert the old style of Minecraft logging (before 1.6.4) and allow them to work with mclogalyzer (located here https://github.com/m0r13/mclogalyzer ), but this tool likely will be beneficial for other uses as well.

If I'm not mistaken, this tool should work with any Linux distribution, as it uses commom BASH commands.

## Running the script ##

**It is important to note that no changes are made to the originating log file.** To run, download/copy the script and change the top two variables.

1. *logfile* is your originating server.log file (unless you have renamed it).
2. *logfolder* is the folder you wish to output the converted files to.

## Ignored Lines ##

Lines that do not start with a date at the start of the line are ignored. This is due to the nature of the script, as file names are created based on the the first entry, generally being the date. All lines that are not formated with a date are ignored. Ignored lines, and their line placement in the *logfile*, are output after the script has been ran fully.

## Issues ##

* If this script is ran twice, any existing information will be appended, thus your new logs will have duplicate entries. It is recommended to output to a test folder before merging with your existing logs.
* WARNING is not changed to WARN.
* This script currently runs pretty slowly. My 4.6MB server.log file took about 15 minutes. I would recommend running this script in a screen if you may get disconnected.
* While I have ran my server with Bukkit briefly, I encountered only one issue with conversion of my large server.log. When issuing a check for users online through the server CLI, the online users were output onto a second line. These lines will be ignored. Your results with Bukkit logs may vary.
* This script does not split logs into multiple files per day. All files are YYYY-MM-DD-1.log.gz
