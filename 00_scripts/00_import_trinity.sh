#!/bin/bash


cd $(pwd)

#clone into trinity
git clone https://github.com/trinityrnaseq/trinityrnaseq 00_scripts/trinity_utils

# clone trinotate
git clone https://github.com/Trinotate/Trinotate 00_scripts/trinotate_utils

#clone transDecoder
git clone https://github.com/TransDecoder/TransDecoder 00_scripts/transdecoder_utils

# clone transvestigator
git clone https://github.com/genomeannotation/transvestigator 00_scripts/transvestigator_utils

#clone transrate
git clone https://github.com/blahah/transrate 00_scripts/transrate_utils

#clone corset
git clone https://github.com/Oshlack/Corset 00_scripts/corset_utils

