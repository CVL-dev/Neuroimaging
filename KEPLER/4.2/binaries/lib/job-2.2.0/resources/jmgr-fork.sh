#!/bin/bash
#
#  '$RCSfile$'
#  '$Author: podhorsz $'
#  '$Date: 2007-08-29 17:53:08 -0700 (Wed, 29 Aug 2007) $'
#  '$Revision: 6428 $'
#
#
# A JobManager based on fork, with very limited functionality
# for job demonstrations using the Kepler workflow system on
# machines without real job management system.
#
# Commands supported
#    -s programfile         to submit a job (start by fork)
#    -t jobID               to get the status of the job (ps with pid)
#    -r jobID               to remove a job (kill with pid)
#    -l [user]              to list the jobs of the given user/all users 
#
# The program is simply started in the current directory. Its stdout
# is redirected to job.out and its stderr to job.err. Therefore it
# is unwise to start two jobs in the same directory.
#
# No logging, accounting, environment handling, file management, etc.
#
# If you are crazy enough to use it for other than occasional demonstrations/tests,
# put a "jmgr-fork.sh -c" command into the cron of all users involved. This
# clears out the /tmp/jobs.$USER file which contains the process ids ever submitted
# through this script.
#
#
#
#
# Copyright (c) 2004 The Regents of the University of California.
# All rights reserved.
#
# Permission is hereby granted, without written agreement and without
# license or royalty fees, to use, copy, modify, and distribute this
# software and its documentation for any purpose, provided that the
# above copyright notice and the following two paragraphs appear in
# all copies of this software.
#
# IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY
# FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES
# ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN
# IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY
# OF SUCH DAMAGE.
#
# THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE
# PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY
# OF CALIFORNIA HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT,
# UPDATES, ENHANCEMENTS, OR MODIFICATIONS.


######################
# set default values #
######################
JOBMGRWORKDIR=/tmp          # where the job manager (this script) stores job ids
CMD=undef

#############
# Functions #
#############

#
# Usage printout
#
function Usage () {
        echo "Usage: `basename $0` -s executable | -t jobID | -r jobID | -l [user] | -c | -h "
        echo "Arguments"
        echo "  -s executable  Submit (using fork) the executable. Returns the process ID as jobID."
        echo "  -t jobID       Get the status of job."
        echo "  -r jobID       Remove (kill) the job."
        echo "  -l [user]      List all submitted jobs or only those of the given user."
        echo "  -c             Clean the user's job list. System maintenance command." 
        echo "  -h             This help"
}


#####################
# Process arguments #
#####################

# process option arguments
while getopts ":s:t:r:lch" Option
do
  case $Option in
        s) EXECUTABLE=$OPTARG;CMD=submit;;
        t) JOBID=$OPTARG;CMD=status;;
        r) JOBID=$OPTARG;CMD=remove;;
        l) CMD=list;;
        c) CMD=clean;;
        h) Usage; exit 0;;
        *) echo "Invalid option -$Option."; Usage; exit 255;;   # DEFAULT
  esac
done
shift $(($OPTIND - 1))


#####################
# Do some work now #
#####################

case "$CMD" in
    # did not specify the command
    "undef" )
        Usage; exit 0
    ;;

    ####################
    # submit a new job #
    ####################
    #   start it and return the process id
    "submit" )
        if [ `basename $EXECUTABLE` == $EXECUTABLE ]; then 
           # user did not say ./  just the file name. Suppose it is a file in current dir
           EXECUTABLE=./$EXECUTABLE
        fi
        [ ! -f $EXECUTABLE ] && echo "$EXECUTABLE does not exist." 1>&2 && exit 1
        [ ! -x $EXECUTABLE ] && echo "$EXECUTABLE is not an executable." 1>&2 && exit 1
        nohup $EXECUTABLE >job.out 2>job.err &
        JOBID=$!
        SUCC=$?
        [ ! $SUCC -eq 0 ] && echo "$EXECUTABLE could not be started." 1>&2 && cat job.err 1>&2 && exit 2
        echo $JOBID >> $JOBMGRWORKDIR/jobs.$USER
        echo "Submitted job $JOBID"
        exit 0
    ;;

    ###################
    # status of a job # 
    ###################
    #   use ps to get the status of the process
    "status" )
        STATUS=`ps -o pid,user,stat,command,bsdstart $JOBID | grep $JOBID`
        [ "$STATUS" == "" ] && echo "No job with id $JOBID found" 1>&2 && exit 1
        echo $STATUS
    ;;

    ################
    # remove a job #
    ################
    #   kill the process and its child processes 
    "remove" )
        # check if such a process exists
        STATUS=`ps $JOBID | grep $JOBID`
        [ "$STATUS" == "" ] && echo "No job with id $JOBID found" 1>&2 && exit 1
        # check if such the process belongs to the user
        STATUS=`ps -u $USER -o pid | grep $JOBID`
        [ "$STATUS" == "" ] && echo "Job $JOBID is not yours. Cannot be removed" 1>&2 && exit 1
        RETVAL=0
        PROCESSES=`ps -o user,pid,ppid -e | grep $JOBID | grep -v grep | awk '{print $2}'`
        for P in $PROCESSES; do        
            #echo "    kill $P: "`ps $P`
            kill -9 $P
            RETVAL=$?
            #[ ! $RETVAL -eq 0 ] && echo "...error, retval=$RETVAL"
        done
        exit $RETVAL
    ;;

    #############
    # list jobs # 
    #############
    #   get potential process ids from /tmp/jobs.* files and get ps on them
    "list" )
        # Let's do the listing now
        if [ -z $1 ]; then 
            JOBS=`cat $JOBMGRWORKDIR/jobs.* 2>/dev/null`
            if [ x"$JOBS" != "x" ]; then
                ps -o pid,user,stat,command,bsdstart $JOBS
            else
                echo "No jobs at all"
            fi
        else
            if [ -f $JOBMGRWORKDIR/jobs.$1 ]; then
                ps -o pid,user,stat,command,bsdstart `cat $JOBMGRWORKDIR/jobs.$1`
            else
                echo "No jobs for user $1"
            fi
        fi
    ;;

    #########################
    # clean user's job list # 
    #########################
    #   processes listed in /tmp/jobs.$USER but not existing will be removed from the list
    "clean" )
        if [ -f $JOBMGRWORKDIR/jobs.$USER ]; then
            hasJobs=no
            for JOBID in `cat $JOBMGRWORKDIR/jobs.$USER`; do
                #echo "check job $JOBID"
                STATUS=`ps -u $USER -o pid | grep $JOBID`
                if [ "$STATUS" != "" ]; then
                    echo $JOBID >> $JOBMGRWORKDIR/jobs.$USER.new 
                    #echo "  is living: $STATUS"
                    hasJobs=yes
                else
                    echo "Job $JOBID does not exist. Remove from list"
                fi
            done
            if [ $hasJobs == yes ]; then
                mv $JOBMGRWORKDIR/jobs.$USER.new $JOBMGRWORKDIR/jobs.$USER
            else 
                rm $JOBMGRWORKDIR/jobs.$USER
            fi
        fi

esac


