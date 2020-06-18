# VCL Setup for Github

A simple, light weight bash script to allow users of the NCSU Virtual Computing Lab (VCL)
to replicate their Linux work environments. 

## Installation

Download the files, and place the `setup_git.zh` and `example.yml` to the root director 
of your ASF mount `/asf/unity.ncsu.edu/users/<first_letter_of_unity_id>/<unity_id>. You can rename the `example.yml` file as you like, typically it would be the name of your project `my_project.yml`. 

If you will be using the SSH protocol to interact with github you will also need to setup SSH keys in the top level of your ASF mount. Follow [these instructions for Linux](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) to generate SSH keys and adding them to your GitHub account. The setup script will move this over to your VCL virtual machine and activate the keys when you run it.

Open up the yaml file in your favorite editor and update the information to fit your situation.

```yaml

# The github username
github_username: <your_github_username>
# The name of the githug repository to be cloned.
repository_name: <name_of_your_repostory>

# Github allows using ssh or http for a uri protocol.
# If you are using 2 factor authentication you will
# need to use ssh and have ssh keys set up.
# https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
# The ssh keys should be in a directory .ssh in your afs directory structure.
protocol: ssh  


```



## Usage

To run the script move to the home directory of your VCL virtual machine and type

```bash
> /asf/unity.ncsu.edu/users/<first_letter_of_unity_id>/<unity_id>/setup_git.sh <your_project.yml>

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
Copyright 2020 Robert Olendorf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
