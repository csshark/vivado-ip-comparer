#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <old_vivado_project_dir> <new_vivado_project_dir>"
  exit 1
fi

OLD_PROJECT_DIR=$1
NEW_PROJECT_DIR=$2

if [ ! -d "$OLD_PROJECT_DIR" ]; then
  echo "Old Vivado project directory does not exist: $OLD_PROJECT_DIR"
  exit 1
fi

if [ ! -d "$NEW_PROJECT_DIR" ]; then
  echo "New Vivado project directory does not exist: $NEW_PROJECT_DIR"
  exit 1
fi

OLD_IP_DIR="$OLD_PROJECT_DIR/ip"
NEW_IP_DIR="$NEW_PROJECT_DIR/ip"

if [ ! -d "$OLD_IP_DIR" ]; then
  echo "Old Vivado project does not contain an 'ip' directory: $OLD_IP_DIR"
  exit 1
fi

if [ ! -d "$NEW_IP_DIR" ]; then
  echo "New Vivado project does not contain an 'ip' directory: $NEW_IP_DIR"
  exit 1
fi

LOG_DIR="./ip_comparison_logs"
mkdir -p "$LOG_DIR"

echo "Comparing IP cores from previous version to new version..."

diff -r "$OLD_IP_DIR" "$NEW_IP_DIR" > "$LOG_DIR/ip_comparison_diff.txt"

if [ -s "$LOG_DIR/ip_comparison_diff.txt" ]; then
  echo "Differences found between IP cores. Check the log file: $LOG_DIR/ip_comparison_diff.txt"
  echo "It might be necessary to recreate connections and verify contents of files"
else
  echo "No differences found between the IP cores in the two Vivado projects."
fi

# Optionally, use 'meld' for a graphical diff (uncomment to use)
# meld "$OLD_IP_DIR" "$NEW_IP_DIR" &

# Ask if user wants to display the changelog
read -p "Do you want to display the changelog for the updated IP cores? (y/n): " DISPLAY_CHANGELOG

if [[ "$DISPLAY_CHANGELOG" =~ ^[Yy]$ ]]; then
  # Loop through the IP cores in the 'new' project directory to check for changelog files
  for ip_dir in "$NEW_IP_DIR"/*; do
    if [ -d "$ip_dir" ]; then
      ip_name=$(basename "$ip_dir")
      changelog_path="/tools/Xilinx/Vivado/$(basename $(dirname $(dirname $ip_dir)))/data/ip/xilinx/${ip_name}/doc/${ip_name}_changelog.txt"

      if [ -f "$changelog_path" ]; then
        echo "Displaying changelog for $ip_name:"
        cat "$changelog_path"
        echo ""
      else
        echo "Changelog for $ip_name not found."
      fi
    fi
  done
fi

exit 0
