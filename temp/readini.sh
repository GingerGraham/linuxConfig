#!/bin/bash
# Read and parse the packages to be installed from packages.conf


# Get/Set single INI section
GetINISection() {
  local filename="$1"
  local section="$2"

  array_name="configuration_${section}"
  declare -g -A ${array_name}
  eval $(awk -v configuration_array="${array_name}" \
             -v members="$section" \
             -F= '{
                    if ($1 ~ /^\[/)
                      section=tolower(gensub(/\[(.+)\]/,"\\1",1,$1))
                    else if ($1 !~ /^$/ && $1 !~ /^;/) {
                      gsub(/^[ \t]+|[ \t]+$/, "", $1);
                      gsub(/[\[\]]/, "", $1);
                      gsub(/^[ \t]+|[ \t]+$/, "", $2);
                      if (section == members) {
                        if (configuration[section][$1] == "")
                          configuration[section][$1]=$2
                        else
                          configuration[section][$1]=configuration[section][$1]" "$2}
                      }
                    }
                    END {
                        for (key in configuration[members])
                          print configuration_array"[\""key"\"]=\""configuration[members][key]"\";"
                    }' ${filename}
        )
}

if [ "$#" -eq "2" ] && [ -f "$1" ] && [ -n "$2" ]; then
  filename="$1"
  section="$2"
  GetINISection "$filename" "$section"

  echo "[${section}]"
  for key in $(eval echo $\{'!'configuration_${section}[@]\}); do
          echo -e "  ${key}: $(apt -qq list $key)"
  done
else
  echo "missing INI file and/or INI section"
fi