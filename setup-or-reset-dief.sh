#!/bin/bash

# get all variables and functions
source functions.sh

cd marvin-extraction
git clone "https://github.com/dbpedia/extraction-framework.git" $DIEFDIR &>/dev/null
cd $DIEFDIR
# reset the ontology and some files that are changes
git stash
git pull

# concat universial props
echo "base-dir=$EXTRACTIONBASEDIR" > $DIEFDIR/core/src/main/resources/universal.properties 
echo "log-dir=$LOGDIR/extraction/" >> $DIEFDIR/core/src/main/resources/universal.properties  
cat $CONFIGDIR/universal.properties.template >> $DIEFDIR/core/src/main/resources/universal.properties 

mvn clean install 2>&1 | tee $LOGDIR/installDIEF.log
