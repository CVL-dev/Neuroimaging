#!/usr/bin/perl

#$host = $ENV{HOSTNAME};
###temp fix since this part doesn't work in kepler.
$host = "agassiz.la.asu.edu";

$inputFile = $ARGV[0];
#print "$inputFile\n";
($directory, $fileName) = $inputFile =~ m/(.*\/)(.*)$/;
#print "D=$directory, F=$fileName\n";
$paramsFile = $ARGV[1];
#print "$paramsFile\n";
$fileNameTMP = $fileName.".tmp";

#####$cmd = "rm /home/efrat/testGrass/webaccess/dbf/$fileName".".dbf";
#####print "$cmd\n";
#####system($cmd);
#####$cmd = "rm -r /home/efrat/testGrass/webaccess/vector/$fileName"."/";
#####print "$cmd\n";
#####system($cmd);

#read parameter file
open(INFILE,".grassrc6") or die "ERROR: Input file unreadable!\n";
while ($line = <INFILE>) {
    $line =~ s/\r/\n/s;
    chomp $line;
    ($key,$val) = split /: /,$line;
    #print "key = $key , val = $val\n";
    $$key = $val;
}
close(INFILE);

#establish database connection
$cmd = "db.connect driver=dbf database=$GISDBASE/$LOCATION_NAME/$MAPSET/dbf/ > $fileNameTMP";
#print "$cmd\n";
system($cmd);

#initialize flags and extensions
$tiffflags = '-t';
$asciiflags = '';
$arcflags = '';
$tiffext = '';
$asciiext = '.asc';
$arcext = '.arc.asc';

#initialize default parameters - WILL BE READ FROM INPUT!!!
#$skip = 1;
$fs = ',';
$res = 6;
#$npoint = 12;
$dmin = 6;
$tension = 40;
$smooth = 0.1;
$segmax = 40;
$npmin = 120;
#$projection = 'stateplane/NA/nad83';
#$units = 'feet';

#initialize boolean values
foreach $key1 (qw(elev slope aspect pcurv)) {
    foreach $key2 (qw(tiff ascii arc view)) {
        $key = $key1.$key2;
        $$key = 0;
    }
}

#read parameter file
open(INFILE,$paramsFile) or die "ERROR: parameter file unreadable!\n";
while ($line = <INFILE>) {
    $line =~ s/\r/\n/s;
    chomp $line;
    ($key,$val) = split /=/,$line;
    $$key = $val;
}
close(INFILE);

#remove parameters file when finished.
### $cmd = "rm -f $paramsFile";
### system($cmd);

#copy the correct projection files into the location
#$cmd = "cp -f projections/$projection/* $GISDBASE/$LOCATION_NAME/PERMANENT/";
#system($cmd);
#$cmd = "cp -f units/$units/PROJ_UNITS $GISDBASE/$LOCATION_NAME/PERMANENT/";
#system($cmd);
#$cmd = "g.region -d";
#system($cmd);

#unzip the uploaded file - MAYBE LATER!
$cmd = "tar zxf $inputFile.pointData.tar.gz";
system($cmd);

$cmd = "sed -e '1,1d' $fileName.txt > $fileName"."_.txt";
system($cmd);
#print "$cmd\n";

#read in the ascii file as a vector points file
$columns = "\'Easting double,Northing double,Height double\'";
###INPUT WILL BE READ FROM COMMAND LINE!!!
$cmd = "v.in.ascii input=$fileName"."_.txt output=V$fileName fs=$fs columns=$columns > $fileNameTMP";
#print "$cmd\n";
system($cmd);

#set the region to encompass the points at the chosen resolution
$cmd = "g.region vect=V$fileName res=$res > $fileNameTMP";
#print "$cmd\n";
system($cmd);

#create a mask raster to limit interpolation area
$cmd = "v.hull -a input=V$fileName output=V$fileName"."Temp > $fileNameTMP";
#print "$cmd\n";
system($cmd);
$cmd = "v.to.rast input=V$fileName"."Temp output=V$fileName use=cat > $fileNameTMP";
#print "$cmd\n";
system($cmd);
###$cmd = "g.remove vect=$fileName,$fileName"."Temp rast=$fileName";
###print "$cmd\n";
###system($cmd);

#set up directory structure
#$proddir = "/opt/jakarta-tomcat/webapps/axis/WEB-INF/classes";
#$dldir = "/export/downloads/$filename";
#
#$cmd = "mkdir $dldir";
#system($cmd);
#

#run v.surf.rst

# determine which derived products to create
foreach $key1 (qw(elev slope aspect pcurv)) {
    foreach $key2 (qw(tiff ascii arc view)) {
        $key = $key1.$key2;
        $$key1 += $$key;
    }
}

$output = '';
foreach $product (qw(elev slope aspect pcurv)) {
    if ($$product) {
        $output = "$output $product=$fileName.$product";
    }
}
    
$cmd = "v.surf.rst zcolumn=Height input=V$fileName $output maskmap=V$fileName dmin=$dmin tension=$tension smooth=$smooth segmax=$segmax npmin=$npmin > $fileNameTMP";
#print "$cmd\n";    
system($cmd);

#create product directories.
$proddir = "/export/downloads/kepler/$fileName";
$cmd = "mkdir $proddir > $fileNameTMP";
system($cmd);

$viewdir = "$proddir/view";
$cmd = "mkdir $viewdir > $fileNameTMP";
system($cmd);

$tgzdir = "$proddir/tgz";
$cmd = "mkdir $tgzdir > $fileNameTMP";
system($cmd);

$tarexists = 0;

#create final products
foreach $product (qw(elev slope aspect pcurv)) {
    if ($$product) {
        $productview = $product.'view';
 
	if ($product eq 'elev') { $newproduct = 'spline'; } else { $newproduct = $product; }

        foreach $format (qw(tiff ascii arc)) {
	    $makeit = $product.$format;
	    
	    if ($$makeit) {
	        $flags = $format.'flags';
	        $ext = $format.'ext';
	   
	        $cmd = "r.out.$format $$flags input=$fileName.$product output=$proddir/$fileName.$newproduct$$ext > $fileNameTMP";
	        #print "$cmd\n";
		system($cmd);

   		if (($format eq 'arc') && $$productview) {
                    $cmd = "cp $proddir/$fileName.$newproduct$$ext $viewdir/.";
		    system($cmd);
		    print "http://$host/downloads/kepler/$fileName/view/$fileName.$newproduct$$ext\n";
                }
 			    
#	        if ($format eq 'tiff') {
#		    print "http://$host/downloads/kepler/$fileName/$fileName.$newproduct.tif\n";
#	        } else {
#		    print "http://$host/downloads/kepler/$fileName/$fileName.$newproduct$$ext\n";
#	        }
            } elsif (($format eq 'arc') && $$productview) {
                #if not $makeit to the arc output but still need to view it - create an arc output to dldir.
                $cmd = "r.out.$format input=$fileName.$product output=$viewdir/$fileName.$newproduct$arcext";
		system($cmd);
		print "http://$host/downloads/kepler/$fileName/view/$fileName.$newproduct$arcext\n";
            }
        }
	if ($tarexists) {
	    $cmd = "cd $proddir; tar -uf $tgzdir/$fileName.tar $fileName.$newproduct.*";
            #print "$cmd\n";
	    system($cmd);

	} else { 
    	    $cmd = "cd $proddir; tar -cf $tgzdir/$fileName.tar $fileName.$newproduct.*"; 
	    system($cmd);
            #print "$cmd\n";
	    $tarexists = 1;
	}
    }
}

#clean up    
$cmd = "gzip -9 $tgzdir/$fileName.tar";
#print "$cmd\n";
system($cmd);
print "http://$host/downloads/kepler/$fileName/tgz/$fileName.tar.gz\n";

$cmd = "rm -f $proddir/$filename*.*";
#### $basedir/$location/PERMANENT/PROJ* $basedir/$location/PERMANENT/*WIND";
system($cmd);

$cmd = "g.remove vect=V$fileName,V$fileName"."Temp rast=V$fileName,$fileName.elev,$fileName.slope,$fileName.aspect,$fileName.pcurv > $fileNameTMP";
system($cmd);

$cmd = "rm -f $fileName.txt $fileName"."_.txt $fileNameTMP";
system($cmd);
#print "$cmd\n";
#
#`rm .grassrc6`;
