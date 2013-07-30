#
# Teem: Tools to process and visualize scientific data and images              
# Copyright (C) 2008, 2007, 2006, 2005  Gordon Kindlmann
# Copyright (C) 2004, 2003, 2002, 2001, 2000, 1999, 1998  University of Utah
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# (LGPL) as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# The terms of redistributing and/or modifying this software also
# include exceptions to the LGPL that facilitate static linking.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this library; if not, write to Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#

#-----------------------------------------------------------------------------
#
# TeemConfig.cmake - Teem CMake configuration file for external projects.
#
# This file is configured by Teem and used by the UseTeem.cmake module
# to load Teem's settings for an external project.

# The Teem source tree.
SET(Teem_SOURCE_DIR "/home/kitware/Dashboards/Package/Slicer-422-package/teem")

# The Teem include file directories.
SET(Teem_EXECUTABLE_DIRS "/usr/local/bin")
SET(Teem_LIBRARY_DIRS "/usr/local/lib/Teem-1.10.0")
SET(Teem_LIBRARIES "teem")
SET(Teem_INCLUDE_DIRS "/usr/local/include")

# The C flags added by Teem to the cmake-configured flags.
SET(Teem_REQUIRED_C_FLAGS "")

# The Teem version number
SET(Teem_VERSION_MAJOR "1")
SET(Teem_VERSION_MINOR "10")
SET(Teem_VERSION_PATCH "0")

# Is Teem using shared libraries?
SET(Teem_BUILD_SHARED_LIBS "ON")
SET(Teem_BUILD_SETTINGS_FILE "/usr/local/lib/Teem-1.10.0/TeemBuildSettings.cmake")

# The location of the UseTeem.cmake file.
SET(Teem_USE_FILE "/usr/local/lib/Teem-1.10.0/TeemUse.cmake")

# The list of tools in teem
SET(Teem_TOOLS "")

# The ExodusII library dependencies.
IF(NOT Teem_NO_LIBRARY_DEPENDS)
  INCLUDE("/usr/local/lib/Teem-1.10.0/TeemLibraryDepends.cmake")
ENDIF(NOT Teem_NO_LIBRARY_DEPENDS)

