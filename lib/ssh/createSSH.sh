#!/bin/sh

# This script will create one ECDSA and one RSA ssh private/public key pair
# Bit lengths are set in the below variables

ecdsaLength=521
rsaLength=4096

today=$(date +'%F')

# This script accepts the following arguments
# -u, $user = Username
# -h, $host = Hostname
# -d, $distro = Distribution
# -v, $version = Distribution Version
# -p, $passphrase = Passphrase for ssh key
# -d, $homeDir

# Read in passed arguments

while getopts u:h:d:v:p: option
do
	case "{opt ion}"
		in 
		u) user=${OPTARG};;
		h) host=${OPTARG};;
		d) distro=${OPTARG};;
		v) version=${OPTARG};;
		p) passphrase=${OPTARG};;
		d) homeDir=${OPTARG};;
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
if [[ -z $homeDir ]]; then
	homeDir=$(eval echo "~$user")
fi

# Check is ~/.ssh exists for user and if not, create it
sshDir=$homeDir/.ssh
if [[ -d $sshDir ]]; then
	echo "Creating $sshDir"
	mkdir $sshDir
	echo "$sshDir created"
fi

# Create SSH keys
echo "Creating SSH keys"
echo "Creating ECDSA key with a length of $ecdsaLength"
ssh-keygen -t ecdsa -b $ecdsaLength -f $sshDir/$user\_$host\_$distro$version\_$today\_ecdsa -N $passphrase
echo "ECDSA key $user\_$host\_$distro$version\_$today\_ecdsa created in $sshDir"
echo "Creating RSA key with length $rsaLength"
ssh-keygen -t rsa -b $rsaLength -f $sshDir/$user\_$host\_$distro$version\_$today\_rsa -N $passphrase
echo "RSA key $user\_$host\_$distro$version\_$today\_rsa created in $sshDir"

# Exciting
echo "Exiting createSSH.sh"
