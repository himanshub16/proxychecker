# proxychecker

The version number is mentioned in the main file : proxychecker.sh

CLI tool to check current proxy configuration in a Linux system.
This helps while debugging/checking current configurations.

Free software licensed under GNU GPL v2.

How to use this tool?
-----------------------
Just execute this tool through bash and it will do its job.


What does it depend on?
-------------------------
Nothing special apart from standard command line utilities as grep.


What does it check?
--------------------
It checks for proxy configurations of following three places : Terminal, Desktop environment, and apt (aka software center, not really).
Technically they are : gsettings : org.gnome.system.proxy
                       /etc/apt/apt.conf
                       .bashrc/.bash_profiles