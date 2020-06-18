#!/bin/bash

function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

name=$(whoami)
dir=${name:0:1}
afs_path="/afs/unity.ncsu.edu/users/$dir/$name/"

eval $(parse_yaml "$afs_path$1")

if [ -d "$afs_path/.ssh" ]; then
     cp -r $afs_path.ssh .
     eval "$(ssh-agent -s)"
     ssh-add ~/.ssh/id_rsa
fi

if [ $protocol == "ssh" ]; then
     uri="git@github.com:$github_username/$repository_name"
     uri="$(echo -e "${uri}" | tr -d '[:space:]')"
     git clone $uri
elif [ $protocol == "http" ]; then
     uri="https://github.com/$github_username/$repository_name.git"
     uri="$(echo -e "${uri}" | tr -d '[:space:]')"
     git clone $uri	
else
     echo "Invalid protocol: $protocol"
fi

# Copy over .bashrc, .profile and .bash_aliases files
# if they exists. This allows users to personalize their
# VCL environment more easily. It is strong encouraged to 
# modify the default files to ensure VCL functionality.
if [ -f "$afs_path/.bashrc" ]; then
     cp $afs_path/.bashrc .
fi

if [ -f "$afs_path/.profile" ]; then
     cp $afs_path/.profile .
fi

if [ -f "$afs_path/.bash_aliases" ]; then
     cp $afs_pat/.bash_aliases .
fi
