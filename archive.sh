#!/bin/bash

# Prints the usage instructions when the -h flag is used:
help_info() {
    echo
    echo "Usage format: $0 <source_directory> <target_directory>"
    echo
    echo "Arguments:"
    echo " - source_directory:  The path to the folder we will make a backup of."
    echo " - target_directory:  The path to the folder where the backup will be stored."
    echo
    echo "Options:"
    echo " - -h                  Show this help message and exit (This flag must be the first argument)"
}

# Handles the -h flag (Help):
if [[ "$1" == "-h" ]]; then
    help_info
    exit 0
fi

# Checks the argument count (Note: Both a source_directory and a target_directory are
# needed for this initial template, but this won't be the case in future parts):
if [[ $# -ne 2 ]]; then
    echo "ERROR: A valid source_directory and target_directory must be provided.  You can learn more about the usage format with the -h flag."
    exit 1
fi

SOURCE="$1"
TARGET="$2"

# Checks if the source_directory exists:
if [[ ! -d "$SOURCE" ]]; then
    echo "ERROR: The given source_directory '$SOURCE' does not exist..."
    exit 1
fi

# We create a new folder in the target_directory with the current timestamp:
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DEST="$TARGET/backup_$TIMESTAMP"

mkdir -p "$DEST" || { echo "ERROR: Could not create target_directory '$DEST'..."; exit 1; }

# Finally, we copy the files from source_directory into this new folder in target_directory:
if cp -rp "$SOURCE"/. "$DEST"/; then
    echo "INFO: Finished backing up files from '$SOURCE' to '$DEST'."
else
    echo "ERROR: Failed to back up files from '$SOURCE' to '$DEST'..."
    exit 1
fi