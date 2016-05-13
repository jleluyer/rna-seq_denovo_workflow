#!/bin/bash


cd $(pwd)

#clone into trinity
git clone https://github.com/trinityrnaseq/trinityrnaseq 00_scripts/trinity_utils


# clone trinotate
git clone https://github.com/Trinotate/Trinotate 00_scripts/trinotate_utils
