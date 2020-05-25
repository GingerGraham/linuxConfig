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
	if [ -f /etc/os-release ]; then
		    # freedesktop.org and systemd
			    . /etc/os-release
				    distro=$NAME
				elif type lsb_release >/dev/null 2>&1; then
					    # linuxbase.org
						    distro=$(lsb_release -si)
						elif [ -f /etc/lsb-release ]; then
							    # For some versions of Debian/Ubuntu without lsb_release command
								    . /etc/lsb-release
									    distro=$DISTRIB_ID
									elif [ -f /etc/debian_version ]; then
										    # Older Debian/Ubuntu/etc.
											    distro=Debian
											elif [ -f /etc/SuSe-release ]; then
												    # Older SuSE/etc.
													    # TODO replace with appropriate code
													elif [ -f /etc/redhat-release ]; then
														    # Older Red Hat, CentOS, etc.
															    # TODO replace with appropriate code
															else
																    # Fall back to uname, e.g.
																	# "Linux <version>", also works
																	# for BSD, etc.
																	    distro=$(uname -s)
	fi
fi
if [[ -z $version ]]; then
	if [ -f /etc/os-release ]; then
		    # freedesktop.org and systemd
			    . /etc/os-release
				    version=$VERSION_ID
				elif type lsb_release >/dev/null 2>&1; then
					    # linuxbase.org
						    version=$(lsb_release -sr)
						elif [ -f /etc/lsb-release ]; then
							    # For some versions of Debian/Ubuntu without lsb_release command
								    . /etc/lsb-release
									    version=$DISTRIB_RELEASE
									elif [ -f /etc/debian_version ]; then
										    # Older Debian/Ubuntu/etc.
											    version=$(cat /etc/debian_version)
											elif [ -f /etc/SuSe-release ]; then
												    # Older SuSE/etc.
													    # TODO replace with appropriate code
													elif [ -f /etc/redhat-release ]; then
														    # Older Red Hat, CentOS, etc.
															    # TODO replace with appropriate code
															else
																    # Fall back to uname, e.g.
																	# "Linux <version>", also works
																	# for BSD, etc.
																	    version=$(uname -r)
	fi
fi
if [[ -z $passphrase ]]; then
	# Verify if they intended to supply a blank passphrase and allow if yes
	echo -n "No passphrase given! Enter a passphrase now, or press ENTER to continue with no
	passphrase: "
	read -s passphrase
fi
