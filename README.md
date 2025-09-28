**Overview:**
This script can be used to create a backup .tar.gz archive of a given source_directory, in the specified target_directory.  You may instead choose to create a backup of the default source/target directories, as specified by the archive.conf configuration file.  If the target_directory does not already exist during execution, the script will create it.  You also have the option of running this script in dry-run mode, which will display the items that WOULD be backed up for the given source/target directories, without performing the actual backup operation.  This script also generates various INFO and ERROR logs, which you can view in the terminal when executing the script, or by looking in the archive.log file, which should be created in your current directory if it doesn't already exist at runtime.  Generally speaking, you should run this script via the terminal while in the autobass directory to ensure proper functionality.

**Installation Instructions:**
You can download this project by going to the "Tags" section of this project, and downloading the zip file source code found under v1.0.  Once you download the project, unzip the folder and open it in the terminal (If you right click the folder in your file explorer, there should be an option to open the folder directly in the terminal).  Navigate to the folder where the archive.sh script is located.  You can run **./archive.sh -h** to see the help info for the script (Which is mostly the same information as what is found here), or you can run the script normally via **./archive.sh** or **./archive.sh <source_directory> <target_directory>** as outlined by the Usage format below.

**Usage format:**
$0 <source_directory> <target_directory>        Runs the script using the given source_directory and target_directory.
$0                                              Runs the script using the default source_directory and target_directory specified in archive.conf

**Arguments:**
 - source_directory:  The path to the folder we will make a backup of.
 - target_directory:  The path to the folder where the backup will be stored.

**Options:**
 - -h         Shows the help message (This flag must be the first argument).
 - -d         Executes the script in dry-run mode (This flag must be the first argument if no
              source_directory and target_directory are given, and the third argument if they are given).

**Configuration file:**
By default, the source_directory is set to './default_source' and the target_directory to './default_target' in the archive.conf file.
Feel free to change the default source_directory and target_directory in the archive.conf file to whatever you'd like.

Exclusion file:
You may add file patterns to the .bassignore file to exclude certain files from the backup process.
 - Example: Adding the pattern '*.log' would exclude all log files.

