
How to build an application and submit it to the CVL repository 

1. Configuring the application build framework in root access:

# cvlcreate <application_name> <version_number>

It creates a build structure in /usr/local/src/<application_name>/<version_number>

2. Download source tarball:

# cd /usr/local/src/<application_name>/<version_number>

# wget <URL>/source.tar.gz

3. Configuration

Edit "config" file for configuration.

Major commands and variables in config file:

* ModuleFileDescription for description of your application (ignore it if you don't package it).

* PACKAGE_RELEASE for package release number (ignore it if you don't package it).

* CONFIGURE - Configure file in your source directory.

* function ConfigurationCommand - A command for configuration (configure --prefix=<prefix> by default).

* function MakeCommand - A command for building (make by default).

* function InstallCommand - A command for installation (make install by default).

* function PatchCommand - A command for source patch.

* EnvironmentModuleList - Set environment module, multiple lines should be delimited by ";". Certian characters such as " and $ need be escapted by "\", (ignore it if you don't package it).

* PackageInstallFileList - Extra files for installation in format of "<Source>:<Destination>", multiple lines must be delimeted by ";". Source files must be available in current source directory (ignore it if you don't package it).

* PackageInstallDirectoryList - Extral directories for installation in format of "<Source>:<Destination>", multiple lines must be delimeted by ";". Source files must be available in current source directory.

* MenuLayout - Add application to menu in in format of <project_type>:<application_menu> (ignore it if you don't package it). 
  The <project_type> should be defined as "cvl". 
  The <application_menu> should be defined as one of following item:
  - "toolbox"
  - "system"
  - "structural-biology"
  - "neuroimaging"
  - "energy-materials"

* MenuDirectory - Create menu directory file in format of <comment>:<icon> (ignore it if you don't package it)

* MenuDesktop - Create menu desktop file in format of <executable_file>:<comment>:<icon>, using delimiter ";" to separate multiple lines (ignore it if you don't package it).

* LibraryDependency - Add library dependencies to environment in format of <module1>:<module2>...:<moduleN> (ignore it if you don't package it).

4. Building the application

If there is no build directory in /usr/local/src/<application_name>/<version_number>, create it:

# mkdir /usr/local/src/<application_name>/<version_number>/Build

# cd /usr/local/src/<application_name>/<version_number>/Build

If a build directory has been created before, clean the cache:

# rm -rf /usr/local/src/<application_name>/<version_number>/Build/*

On success, the software will be installed in /usr/local/<application_name>/<version_number>.

5. Testing (optional)

# cvlbuild -t

6. Generating RPM package (optional)

# cvlbuild -p

7. Managing dependencies

The group installation file "CVL Build System" contains all necessary dependencies we know as of today. If your applications require extra libraries, please let us know, we'll update the "CVL Build System" package.

8. Submitting it to the CVL

CVL build system is still in development stage, CVL team will take responsibility of packaging software and adding packages to CVL repository for the time being. Please send us detailed application information (source package, build processes, dependencies, initialization and running procedure). For support, assistance or bug report, please contact to CVL team at jupiterh@vpac.or.


