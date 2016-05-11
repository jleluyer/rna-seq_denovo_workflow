#!/bin/bash

#pre-requis
module load apps/git/1.8.5.3 
module load apps/trinityrnaseq/2.1.1

cd $(pwd)

#clone into trinity
git clone https://github.com/trinityrnaseq/trinityrnaseq 00_scripts/trinity_utils
