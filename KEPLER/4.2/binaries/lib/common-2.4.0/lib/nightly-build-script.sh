#!/bin/sh
################################################################################
#     '$RCSfile$'
#     '$Author: welker $'
#     '$Date: 2010-05-05 22:21:26 -0700 (Wed, 05 May 2010) $'
#     '$Revision: 24234 $'
################################################################################
################################################################################
# This script runs a nightly build for kepler.  It checks kepler against
# the head of the PTII tree.  The process is as follows:
# 1) checkout kepler
# 2) checkout PTII
# 3) compile KEPLER and PTII with ant
# 4) report compile problems
# 5) if there are no compile problems, run kepler junit tests
# 6) report junit problems
# 7) run momlexecute on the list of workflows found in kepler/lib/test-workflows.lst
# 8) report any workflow problems
################################################################################
# set the variables.
CVSUSER=kepler
CVSSERVER=cvs.ecoinformatics.org
CVSREPOSITORY=/cvs
CVSROOT=:ext:$CVSUSER@$CVSSERVER:$CVSREPOSITORY
CVS_RSH=ssh
CVSMODULE=kepler
JAVA_HOME=/usr/java/jdk1.5.0_09
ANT_HOME=/usr/local/devtools/apache-ant
ANT=$ANT_HOME/bin/ant
KEPDIR=~kepler/.kepler
WORKDIR=~kepler/$CVSMODULE-nightly-build
PTII=$WORKDIR/ptII
KEPLER=$WORKDIR/kepler
BUILDLOG=$WORKDIR/build.log
WFLOG=$WORKDIR/workflow-execute.log
JUNITLOG=$WORKDIR/junit.log
HTMLFILE=$WORKDIR/results.html
EMAILFILE=$WORKDIR/email.txt
CSSFILE=$WORKDIR/style.css
SWFLIST=$WORKDIR/$CVSMODULE/lib/test-workflows.lst
HTMLINSTALL=/var/www/org.kepler-project.www/ROOT/nightly
KEPLER_DOCS=$WORKDIR/kepler-docs

#
# Set DISPLAY to :0.0 only if not set outside the script.
DISPLAY=${DISPLAY:-:0.0}

# QUICK controls if the ptII and kepler cvs modules are checked out
# fresh.  If QUICK is set to true, then the entire nightly-build
# directory is blown away and new fresh copies of ptII and kepler
# are checked out.
#
# QUICK will default to false unless set outside of the script.
# The default behavior is to do a fresh clean build every execution.
# This can be overridden on the command line by doing:
# 
# QUICK=true nightly-build-script.sh
#
QUICK=${QUICK:-false}

export CVSROOT=$CVSROOT CVS_RSH=$CVS_RSH ANT_HOME=$ANT_HOME JAVA_HOME=$JAVA_HOME PTII=$PTII DISPLAY=$DISPLAY KEPLER_DOCS=$KEPLER_DOCS KEPLER=$KEPLER

# if workdir exists, remove it and remake it
if [ "$QUICK" = "false" ]
then
echo REMOVING WORKING DIR $WORKDIR
rm -rf $WORKDIR
echo REMOVING .KEPLER DIR $KEPDIR
rm -rf $KEPDIR
mkdir $WORKDIR
fi
cd $WORKDIR

BEGIN=`date  +'%y%h%d-%T'`
echo BEGIN TIME IS $BEGIN

# Start the HTML
rm $HTMLFILE
touch $HTMLFILE
echo "<html><head><link rel="stylesheet" type="text/css" href="style.css"></head>" >> $HTMLFILE
echo "<body><h1>Kepler Nightly Build System</h1>" >> $HTMLFILE
echo "<hr>" >> $HTMLFILE
echo "<h2>Begin " >> $HTMLFILE
echo $BEGIN >> $HTMLFILE
echo "</h2>" >> $HTMLFILE
echo "<hr>" >> $HTMLFILE

echo "<h2>Jump to...(Red links have build errors, green do not)</h2>" >> $HTMLFILE
echo "<a class=\"coBroken\" href=\"#checkout\">Ptolemy and Kepler Checkouts</a><br>" >> $HTMLFILE
echo "<a class=\"ptBuildBroken\" href=\"#ptbuild\">Ptolemy Build Results</a><br>" >> $HTMLFILE
echo "<a class=\"keplerBuildBroken\" href=\"#keplerbuild\">Kepler Build Results</a><br>" >> $HTMLFILE
echo "<a class=\"jUnitBroken\" href=\"#junit\">Junit Unit Test Results</a><br>" >> $HTMLFILE
echo "<a class=\"workflowBroken\" href=\"#workflow\">Workflow Test Results</a><br>" >> $HTMLFILE
echo "<a class=\"keplerDocsBroken\" href=\"#keplerDocsbuild\">Kepler Docs Results</a><br>" >> $HTMLFILE
echo "<br>" >> $HTMLFILE

# Start the email file
rm $EMAILFILE
touch $EMAILFILE
echo "Kepler Nightly Build Email Summary" >> $EMAILFILE
echo "For a full report go to http://www.kepler-project.org/nightly" >> $EMAILFILE
echo "-------------------------------------------------------------" >> $EMAILFILE
echo "Build started " $BEGIN >> $EMAILFILE

echo "<a name=\"checkout\"><h3>Checkouts</h3>" >> $HTMLFILE

###################
# checkout kepler #
###################
if [ "$QUICK" = "false" ]
then
  echo CHECKING OUT KEPLER
  cvs -d $CVSROOT co -P $CVSMODULE
fi

echo "<h3>Kepler successfully checked out.</h3>" >> $HTMLFILE

########################
# checkout kepler-docs #
########################
if [ "$QUICK" = "false" ]
then
  echo CHECKING OUT KEPLER-DOCS
  cvs -d $CVSROOT co -P kepler-docs
fi

echo "<h3>Kepler-Docs successfully checked out.</h3>" >> $HTMLFILE

###################################################### 
# checkout ptolemy. note the password in the cvsroot #
######################################################
CVSROOT=:pserver:anon:@source.eecs.berkeley.edu:/home/cvs/cvsanon
export CVSROOT=$CVSROOT
export CVS_RSH=
cvs login
if [ "$QUICK" = "false" ]
then
  echo CHECKING OUT PTII
  cvs co ptII
fi

echo "<h3>PTII successfully checked out.</h3>" >> $HTMLFILE

# build ptII and kepler
cd $CVSMODULE
# note the hack below....codegen never compiles right.
rm -rf $WORKDIR/ptII/ptolemy/codegen
rm -rf $WORKDIR/ptII/ptolemy/backtrack
export PTII=$WORKDIR/ptII
export KEPLER=$WORKDIR/$CVSMODULE

COBROKEN=#00FF00

#################
# build ptolemy #
#################
echo "<a name=\"ptbuild\"/>" >> $HTMLFILE
echo BUILDING PTII
$ANT -l $BUILDLOG ptolemy

# check to see if it was successful
SUCCESS=`grep "BUILD FAILED" $BUILDLOG`
PTBUILDBROKEN=#00FF00
if [ "$SUCCESS" = "BUILD FAILED" ]
then
  echo PTII BUILD FAILED
  echo "Ptolemy Build Failed: " >> $EMAILFILE
  echo "See http://www.kepler-project.org/nightly/today.html#ptbuild" >> $EMAILFILE
  echo "<h3>Ptolemy Build Results: <em>BUILD FAILED</em> </h3>" >> $HTMLFILE
  PTBUILDBROKEN=#FF0000
else
  echo PTII BUILD SUCCESSFUL
  echo "Ptolemy Build Successful" >> $EMAILFILE
  echo "<h3>Ptolemy Build Results: BUILD SUCCESSFUL</h3>" >> $HTMLFILE
fi

# print the log to the html file no matter what
echo "<pre>" >> $HTMLFILE
cat $BUILDLOG >> $HTMLFILE
echo "</pre>" >> $HTMLFILE

################
# build kepler #
################
echo "<a name=\"keplerbuild\"/>" >> $HTMLFILE
echo BUILDING KEPLER
$ANT -l $BUILDLOG install

SUCCESS=`grep "BUILD FAILED" $BUILDLOG`
KEPLERBUILDBROKEN=#00FF00
if [ "$SUCCESS" = "BUILD FAILED" ]
then
  echo KEPLER BUILD FAILED
  echo "Kepler Build Failed: " >> $EMAILFILE
  echo "See http://www.kepler-project.org/nightly/today.html#keplerbuild" >> $EMAILFILE
  echo "<h3>Kepler Build Results: <em>BUILD FAILED</em></h3>" >> $HTMLFILE
  KEPLERBUILDBROKEN=#FF0000
else
  echo KEPLER BUILD SUCCESSFUL
  echo "Kepler Build Successful" >> $EMAILFILE
  echo "<h3>Kepler Build Results: BUILD SUCCESSFUL</h3>" >> $HTMLFILE
fi

# print the log to the html file no matter what
echo "<pre>" >> $HTMLFILE
cat $BUILDLOG >> $HTMLFILE
echo "</pre>" >> $HTMLFILE


#######################
# run the junit tests #
#######################
echo RUNNING JUNIT TESTS
echo "<a name=\"junit\"/>" >> $HTMLFILE
echo "<h3>Begin Kepler JUnit Tests</h3>" >> $HTMLFILE
$ANT -l $JUNITLOG test
SUCCESS=`grep "FAILED" $JUNITLOG`
echo "" >> $EMAILFILE
echo "JUnit Tests:" >> $EMAILFILE
JUNITBROKEN=#00FF00
if [ "$SUCCESS" = "" ]
then
  # all unit tests passed
  echo JUNIT TESTS SUCCESSFUL
  echo "All unit tests passed." >> $EMAILFILE
  echo "<h3>All unit tests passed.</h3>" >> $HTMLFILE
else
  # not all unit tests passed
  echo JUNIT TESTS FAILED
  echo "Some or all of the unit tests FAILED: " >> $EMAILFILE
  echo $SUCCESS >> $EMAILFILE
  echo "<em>Some or all of the unit tests FAILED: " >> $HTMLFILE
  echo $SUCCESS >> $HTMLFILE
  echo "</em>" >> $HTMLFILE
  JUNITBROKEN=#FF0000
fi

echo "<h3>Kepler JUnit Log</h3>" >> $HTMLFILE
echo "<pre>" >> $HTMLFILE
cat $JUNITLOG >> $HTMLFILE
echo "</pre>" >> $HTMLFILE
echo "<h3>End Kepler JUnit Tests</h3>" >> $HTMLFILE

###############################
# run the momlexecute workflows #
###############################
echo EXECUTING WORKFLOWS
echo "" >> $EMAILFILE
echo "Workflow Tests:" >> $EMAILFILE
echo "For today's workflow test results visit http://www.kepler-project.org/nightly/today.html#workflow" >> $EMAILFILE
echo "<a name=\"workflow\"/>" >> $HTMLFILE
# open the $SWFLIST file and execute each workflow in the list
echo "<h3>Begin Workflow Tests</h3>" >> $HTMLFILE
rm $WORKDIR/workflow.broken
WORKFLOWBROKEN=#00FF00
$ANT build_momlexecute_sh
# following command should eliminate multiple spaces, replace remaining with tabs, and then return 1st item (path)
# this will not work if there are spaces in path names in workflow test list - Dan Higgins 4 April 2006
cat $SWFLIST |tr -s ' ' | tr ' ' '\t' | cut -f1 | while read WF
do
  echo TESTING WORKFLOW $WF
  echo "<h3>testing workflow:" >> $HTMLFILE
  echo $WF >> $HTMLFILE
  echo "</h3>" >> $HTMLFILE
#  $ANT -l $WFLOG momlexecute.sh -Dworkflow=$WF
  ./momlexecute.sh $WF > $WFLOG
  
  # Check for any Exceptions, but ignore the IOException from
  # missing ptII.properties.
  SUCCESS=`grep "Exception" $WFLOG | grep -v ptII.properties`
  X11ERROR=`grep "InternalError" $WFLOG`
  if [ "$SUCCESS" = "" ] && [ "$X11ERROR" = "" ]
  then
    echo WORKFLOW $WF SUCCESSFUL
    echo "<h2>Workflow $WF threw no exceptions.</h2>" >> $HTMLFILE
  else
    echo WORKFLOW $WF FAILED
    echo $SUCCESS >> $WFLOG.error
    X11ERROR=`grep "X11" $WFLOG.error`
    touch $WORKDIR/workflow.broken
    if [ "$X11ERROR" = "" ]
    then
      # the workflow test failed
      echo "Workflow $WF FAILED: " >> $EMAILFILE
      echo $SUCCESS >> $EMAILFILE
      echo "<em>Workflow test FAILED: " >> $HTMLFILE
      echo "<pre>$SUCCESS</pre>" >> $HTMLFILE
      echo "</em>" >> $HTMLFILE
    else
      # this is a special case where we tried to run a workflow with visual
      # elements...this won't run without a display so it failed.
      echo "<p><em>This workflow is attempting to create visual elements." >> $HTMLFILE
      echo "This workflow may be executing correctly, but momlexecute " >> $HTMLFILE
      echo "cannot find an X Server to use.  DISPLAY is $DISPLAY</em></p>" >> $HTMLFILE
      
      echo "The workflow $WF is attempting to create visual elements" >> $EMAILFILE
      echo "but cannot because the DISPLAY $DISPLAY is not set right or no X Server is running." >> $EMAILFILE
      echo "" >> $EMAILFILE
    fi
  fi
  echo "<pre>" >> $HTMLFILE
  cat $WFLOG >> $HTMLFILE
  echo "</pre>" >> $HTMLFILE
done

if [ -a $WORKDIR/workflow.broken ]
then
  WORKFLOWBROKEN=#FF0000
fi

echo "<h3>End Workflow Tests</h3>" >> $HTMLFILE

########################
# generate kepler-docs #
########################
echo "<a name=\"keplerDocsbuild\"/>" >> $HTMLFILE
echo GENERATING KEPLER-DOCS
$ANT -l $BUILDLOG generateDoc

rm -rf ~kepler/nightly/docResults
mkdir ~kepler/nightly/docResults

SUCCESS=`grep "BUILD FAILED" $BUILDLOG`
KEPLERDOCSBROKEN=#00FF00
if [ "$SUCCESS" = "BUILD FAILED" ]
then
  echo KEPLER-DOCS BUILD FAILED
  echo "Kepler-Docs Build Failed: " >> $EMAILFILE
  echo "See http://www.kepler-project.org/nightly/today.html#keplerDocsbuild" >> $EMAILFILE
  echo "<h3>Kepler-Docs Build Results: <em>BUILD FAILED</em></h3>" >> $HTMLFILE
  KEPLERDOCSBROKEN=#FF0000
else
  echo KEPLER-DOCS BUILD SUCCESSFUL
  echo "Kepler-Docs Build Successful" >> $EMAILFILE 	
  cp -r ~kepler/kepler-nightly-build/kepler-docs/dev/documentationFramework/docCheck ~kepler/nightly/docResults
  cp -r ~kepler/kepler-nightly-build/kepler-docs/dev/documentationFramework/generatedHTMLPages ~kepler/nightly/docResults
  cp -r ~kepler/kepler-nightly-build/kepler-docs/dev/documentationFramework/generatedJavadocs ~kepler/nightly/docResults
  echo "See http://www.kepler-project.org/nightly/docResults/docCheck#DocCheckResults" >> $EMAILFILE
  echo "See http://www.kepler-project.org/nightly/docResults/generatedJavadocs#JavadocsGenerated" >> $EMAILFILE
  echo "See http://www.kepler-project.org/nightly/docResults/generatedHTMLPages/FinalDeveloperDocumentation.html#DeveloperDocumentation" >> $EMAILFILE
  echo "See http://www.kepler-project.org/nightly/docResults/generatedHTMLPages/FinalUserDocumentation.html#UserDocumentation" >> $EMAILFILE
  echo "<h3>Kepler-Docs Build Results: BUILD SUCCESSFUL</h3>" >> $HTMLFILE
fi

# print the log to the html file no matter what
echo "<pre>" >> $HTMLFILE
cat $BUILDLOG >> $HTMLFILE
echo "</pre>" >> $HTMLFILE
                              


########################
# build keplerzip file #
########################
$ANT -l $BUILDLOG buildkeplerzip
rm ~kepler/nightly/zip/3daysold.zip
mv ~kepler/nightly/zip/2daysold.zip ~kepler/nightly/zip/3daysold.zip
mv ~kepler/nightly/zip/1dayold.zip ~kepler/nightly/zip/2daysold.zip
mv ~kepler/nightly/zip/kepler*.zip ~kepler/nightly/zip/1dayold.zip
cp $WORKDIR/kepler/zipdir/kepler*.zip ~kepler/nightly/zip
echo KEPLER ZIPPED FILE CREATED

###########################
# Finish up the HTML file #
###########################
echo FINISHING UP HTML FILES
END=`date  +'%y%h%d-%T'`
echo "<hr>" >> $HTMLFILE
echo "<h2>End " >> $HTMLFILE
echo $END >> $HTMLFILE
echo "</h2>" >> $HTMLFILE
echo "<hr>" >> $HTMLFILE
echo "</body></html>" >> $HTMLFILE

# Install the HTML file into the web server directory and rotate the log
cp $HTMLFILE $HTMLINSTALL/$END.html
cp $HTMLINSTALL/$END.html $HTMLINSTALL/today.html
echo "" >> $EMAILFILE
echo "------------------------------------------" >> $EMAILFILE
echo "Build ended at $END" >> $EMAILFILE

# write out the CSS.  this is done dymanically so the quick links can be colored red and green
echo WRITING OUT CSS
echo "em {" >> $CSSFILE
echo "  color: #FF0000;" >> $CSSFILE 
echo "  font-weight: bold;" >> $CSSFILE
echo "  font-style:  normal;" >> $CSSFILE
echo "}" >> $CSSFILE

echo ".coBroken {" >> $CSSFILE
echo "  color: $COBROKEN;" >> $CSSFILE
echo "}" >> $CSSFILE

echo ".ptBuildBroken {" >> $CSSFILE
echo "  color: $PTBUILDBROKEN;" >> $CSSFILE
echo "}" >> $CSSFILE

echo ".keplerBuildBroken {" >> $CSSFILE
echo "  color: $KEPLERBUILDBROKEN;" >> $CSSFILE
echo "}" >> $CSSFILE

echo ".jUnitBroken {" >> $CSSFILE
echo "  color: $JUNITBROKEN;" >> $CSSFILE
echo "}" >> $CSSFILE

echo ".workflowBroken {" >> $CSSFILE
echo "  color: $WORKFLOWBROKEN;" >> $CSSFILE
echo "}" >> $CSSFILE
# install the CSS file
cp $CSSFILE $HTMLINSTALL/style.css

echo ".keplerDocsBroken {" >> $CSSFILE
echo "  color: $KEPLERDOCSBROKEN;" >> $CSSFILE
echo "}" >> $CSSFILE

# Send out the email
echo SENDING EMAIL
$ANT nightlybuild.notify -Dattach=$EMAILFILE -Ddate=$END

echo DONE AT $END
