""" This module loads the Slicer library modules into its namespace."""

import imp

# Add module 'slicer.modules'
__modules = imp.new_module( 'modules' )
globals()[__modules.__name__] = __modules

# Add module 'slicer.moduleNames'
__moduleNames = imp.new_module( 'moduleNames' )
globals()[__moduleNames.__name__] = __moduleNames

__kits_to_load = [ 
# slicer libs
'freesurfer',
'mrml',
'mrmlLogic',
'remoteio',
'teem',
'qMRMLWidgetsPythonQt',
# slicer base libs
'logic',
'qSlicerBaseQTCorePythonQt',
'qSlicerBaseQTGUIPythonQt',
'qSlicerBaseQTAppPythonQt',
# slicer module
'modulelogic',
'modulemrml',
'modulewidget',
# CLI logic (Slicer_BUILD_CLI_SUPPORT:ON)
'mrmlcli',
'qSlicerBaseQTCLIPythonQt',
 ]

for kit in __kits_to_load:
   try:
     exec "from %s import *" % (kit)
   except ImportError as detail:
     print detail

# Removing things the user shouldn't have to see.
del __kits_to_load
del __modules, __moduleNames
del imp
