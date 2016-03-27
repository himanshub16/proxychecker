#!/bin/bash
# proxy_check v1.3
# Author : Himanshu Shekhar < https://github.com/himanshushekharb16/ProxyMan >

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.
#
# This is a simple tool to check proxy configurations for GNU/Linux distributions of
# the Debian/Ubuntu/Fedora familiy. Helps in debugging.
# The README.md file provides more information.


#!/bin/bash
if [[ -e "$HOME/.bashrc" ]]; then
	a=$(grep -i proxy $HOME/.bashrc | wc -l)
	if [[ a -eq 0 ]]; then
		echo ".bashrc is not using proxy."
	else
		echo "For ~/.bashrc..."
		grep -i proxy $HOME/.bashrc
	fi
else
	echo ".bashrc does not exist."
fi

echo

if [[ -e "$HOME/.bash_profile" ]]; then
	a=$(grep -i proxy $HOME/.bash_profile | wc -l)
	if [[ a -eq 0 ]]; then
		echo ".bash_profile is not using proxy."
	else
		echo "For ~/.bash_profile..."
		grep -i proxy $HOME/.bash_profile
	fi
else
	echo ".bash_profile does not exist."
fi

echo 

if [[ -e "/etc/environment" ]]; then
	a=$(printenv | grep -i proxy)
	if [[ a -eq 0 ]]; then
		echo "/etc/environment is not using proxy."
	else
		echo "For /etc/envrionment..."
		printenv | grep -i proxy
	fi
else
	echo "/etc/environment does not exist."
fi

echo

# if apt is installed
if [[ -e "/etc/apt/" ]]; then
	if [[ -e "/etc/apt/apt.conf" ]]; then
		echo "This is apt.conf ..."
		cat "/etc/apt/apt.conf"
	else
		echo "apt is not using proxy."
	fi
fi

# if dnf is installed
if [[ -e "/etc/dnf" ]]; then
	if [[ -e "/etc/dnf/dnf.conf" ]]; then
		echo "This is dnf.conf"
		cat "/etc/dnf/dnf.conf" | grep "proxy"
	else
		echo "dnf.conf does not use proxy"
	fi
fi

echo

mode=$(gsettings get org.gnome.system.proxy mode)
if [[ $mode == "'none'" ]]; then
	echo "The desktop environment is not using any proxy settings."
	echo "Thus, gsettings configurations are ineffective."
elif [[ $mode == "'manual'" ]]; then
	echo "The desktop environment is using manual proxy settings."
	echo "Thus, following gsettings configurations are effective."
	gsettings list-recursively org.gnome.system.proxy
else
	echo "We cannot determine the type of settings. Sorry :("
fi
