#!/bin/sh


TK="#!/usr/bin/wish\n
\n
proc Scrolled_Text { f args } { \n
    frame \$f \n
    eval {text \$f.text -wrap none 
        -xscrollcommand [list \$f.xscroll set] 
        -yscrollcommand [list \$f.yscroll set]} $args \n
    scrollbar \$f.xscroll -orient horizontal 
        -command [list \$f.text xview] \n
    scrollbar \$f.yscroll -orient vertical 
        -command [list \$f.text yview] \n
    grid \$f.text \$f.yscroll -sticky news \n
    grid \$f.xscroll -sticky news \n
    grid rowconfigure \$f 0 -weight 1 \n
    grid columnconfigure \$f 0 -weight 1 \n
    return \$f.text \n
} \n
\n
set t [Scrolled_Text .eval -width 80 -height 20] \n
pack .eval -fill both -expand true \n
\n
set Agreement { \n
FMRIB Software Library, Release 5.0 (c) 2012, The University of Oxford(the \"Software\") \n
\n
The Software remains the property of the University of Oxford (\"the University\"). \n
\n
The Software is distributed \"AS IS\" under this Licence solely for \n
non-commercial use in the hope that it will be useful, but in order \n
that the University as a charitable foundation protects its assets for \n
the benefit of its educational and research purposes, the University \n
makes clear that no condition is made or to be implied, nor is any \n
warranty given or to be implied, as to the accuracy of the Software, \n
or that it will be suitable for any particular purpose or for use \n
under any specific conditions. Furthermore, the University disclaims \n
all responsibility for the use which is made of the Software. It \n
further disclaims any liability for the outcomes arising from using \n
the Software. \n
\n
The Licensee agrees to indemnify the University and hold the \n
University harmless from and against any and all claims, damages and \n
liabilities asserted by third parties (including claims for \n
negligence) which arise directly or indirectly from the use of the \n
Software or the sale of any products based on the Software. \n
\n
No part of the Software may be reproduced, modified, transmitted or \n
transferred in any form or by any means, electronic or mechanical, \n
without the express permission of the University. The permission of \n
the University is not required if the said reproduction, modification, \n
transmission or transference is done without financial return, the \n
conditions of this Licence are imposed upon the receiver of the \n
product, and all original and amended source code is included in any \n
transmitted product. You may be held legally responsible for any \n
copyright infringement that is caused or encouraged by your failure to \n
abide by these terms and conditions. \n

You are not permitted under this Licence to use this Software \n
commercially. Use for which any financial return is received shall be \n
defined as commercial use, and includes (1) integration of all or part \n
of the source code or the Software into a product for sale or license \n
by or on behalf of Licensee to third parties or (2) use of the \n
Software or any derivative of it for research with the final aim of \n
developing software products for sale or license to a third party or \n
(3) use of the Software or any derivative of it for research with the \n
final aim of developing non-software products for sale or license to a \n
third party, or (4) use of the Software to provide any service to an \n
external organisation for which payment is received. If you are \n
interested in using the Software commercially, please contact Isis \n
Innovation Limited ("Isis"), the technology transfer company of the \n
University, to negotiate a licence. Contact details are: \n
innovation@isis.ox.ac.uk quoting reference BS/9564. \n
\n
\n
------------------------------------------------------------------- \n
\n
The Standard Space Atlases \n
\n
The Cerebellum, Harvard-Oxford, JHU, Juelich, Striatum and Thalamus atlases, \n
whilst not being the property of Oxford, are released under the terms of the \n
main FSL licence above, at the request of their owners. These atlases \n
should therefore not be used for commercial purposes; for such \n
purposes please contact the primary co-ordinator for the relevant \n
atlas: \n
\n
Harvard-Oxford: steve@fmrib.ox.ac.uk \n
JHU: susumu@mri.jhu.edu \n
Juelich: S.Eickhoff@fz-juelich.de \n
Thalamus: behrens@fmrib.ox.ac.uk \n
Cerebellum: j.diedrichsen@bangor.ac.uk \n
Striatum: andri.tziortzi@gmail.com \n
\n
------------------------------------------------------------------- \n
\n
FSLView \n
\n
FSLView sources are released under the terms of the GPLv2 \n
(http://www.gnu.org/licenses/old-licenses/gpl-2.0.html). FSLView \n
binaries use Qt (http://qt.nokia.com) which is released under LGPLv2.1. \n
The FSLView binaries are released under the GPL, with the added \n
exception that we also give permission to link this program with the Qt \n
non-commercial edition, and distribute the resulting executable, \n
without including the source code for the Qt non-commercial edition in \n
the source distribution. \n
\n
FSLView is distributed \"AS IS\" under this Licence in the hope that it \n
will be useful, but in order that the University as a charitable \n
foundation protects its assets for the benefit of its educational and \n
research purposes, the University makes clear that no condition is \n
made or to be implied, nor is any warranty given or to be implied, as \n
to the accuracy of the Software, or that it will be suitable for any \n
particular purpose or for use under any specific conditions. \n
Furthermore, the University disclaims all responsibility for the use \n
which is made of the Software. It further disclaims any liability for \n
the outcomes arising from using the Software. \n
\n
Do you accept this license condition? \n
} \n

\$t configure -state normal \n
\$t insert end \$Agreement \n
\$t configure -state disabled \n

frame .ok -borderwidth 1 -relief sunken \n
button .ok.b -text Yes -command {exit 0} \n
pack .ok.b -padx 5 -pady 5 \n
button .cancel -text No -command {exit 1} \n
pack .ok .cancel -side left -padx 5 -pady 5 \n
"

echo -e ${TK} > /usr/local/bin/License

chmod 777 /usr/local/bin/License

/usr/local/bin/License

response=$?

rm -f /usr/local/bin/License

if [[ ${response} == 0 ]]; then
    echo "License accepted"
else
    echo "License not accepted"
    exit 1
fi

