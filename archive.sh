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

# Takes a log as input, and both prints it to the terminal and records it in the archive.log file with a timestamp:
create_log() {
    local LOG_TYPE="$1"
    local LOG_MESSAGE="$2"
    local LOG_TIMESTAMP=$(date +"%m/%d/%Y %H:%M:%S")

    local LOG="$LOG_TYPE: [$LOG_TIMESTAMP] $LOG_MESSAGE"
    
    # Depending on the LOG_TYPE, we print the log to stdout (INFO) or stderr (ERROR):
    if [[ "$LOG_TYPE" == "INFO" ]]; then
        echo "$LOG"
    else
        echo "$LOG" >&2
    fi

    # We then print the log to archive.log:
    echo "$LOG" >> "$LOG_FILE"
}

# Handles the -h flag (Help):
if [[ "$1" == "-h" ]]; then
    help_info
    exit 0
fi

# We create a log file in the current directory to record all the logs generated during execution:
LOG_FILE="./archive.log"
create_log "INFO" "archive script started."

# We use the source_directory and target_directory arguments given by the user:
if [[ $# -ge 2 ]]; then
    SOURCE="$1"
    TARGET="$2"

# If these arguments were not given, we instead use the default values in archive.conf:
else
    CONFIG_FILE="./archive.conf"
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    else
        create_log "ERROR" "Configuration file ($CONFIG_FILE) not found."
        exit 1
    fi
fi

# Checks if the source_directory exists:
if [[ ! -d "$SOURCE" ]]; then
    create_log "ERROR" "Source directory ($SOURCE) does not exist or is not readable. Exiting."
    exit 1
fi

# Checks if the target_directory exists.  If not, we attempt to create it:
if [[ ! -d "$TARGET" ]]; then
    mkdir -p "$TARGET"

    if [[ ! -d "$TARGET" ]]; then
        create_log "ERROR" "Target directory ($TARGET) does not exist or could not be created. Exiting."
        exit 1
    fi
fi

# We create a .tar.gz archive in the target_directory with the current timestamp:
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE="$TARGET/backup_$TIMESTAMP.tar.gz"

# Finally, we copy the files from source_directory into this new .tar.gz archive:
create_log "INFO" "Backing up from $SOURCE to $ARCHIVE."

if tar -czf "$ARCHIVE" -C "$SOURCE" .; then
    create_log "INFO" "Backup completed successfully."
    exit 0
else
    create_log "ERROR" "Backup failed during compression."
    exit 1
fi

