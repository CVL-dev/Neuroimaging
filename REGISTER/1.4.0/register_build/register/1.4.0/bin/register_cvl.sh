#!/bin/sh
if [ ! -f /tmp/build_mod_load ]; then touch /tmp/build_mod_load; chmod 777 /tmp/build_mod_load; fi;
#load modules
module load virtualgl 2> /tmp/build_mod_load
module load libjpeg-turbo 2> /tmp/build_mod_load
module load minc 2> /tmp/build_mod_load
module load register 2> /tmp/build_mod_load
#execute
vglrun register
