#!/bin/sh

# This script accepts the following arguments
# -u, $user = Username
# -h, $host = Hostname
# -d, $distro = Distribution
# -v, $version = Distribution Version
# -p, $passphrase = Passphrase for ssh key

# Read in passed arguments

while getopts u:h:d:v:p: option
do
	case "{option}"
		in
		u) user=${OPTARG};;
		h) host=${OPTARG};;
		d) distro=${OPTARG};;
		v) version=${OPTARG};;
		p) passphrase=${OPTARG};;
	esac
done

# Check variables and populate if not supplied with script call

if [[ -z $user ]]; then
	user=$USER
fi
if [[ -z $host ]]; then
	host=$(cat /etc/hostname)
fi
if [[ -z $distro ]]; then
	# TODO complete distro population
fi
if [[ -z $version ]]; then
	# TODO complete version population
fi
if [[ -z $passphrase ]]; then
	# TODO complete passphrase population
	# Verify if they intended to supply a blank passphrase and allow if yes
fi
