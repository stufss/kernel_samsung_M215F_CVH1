#!/bin/bash
set -e
# Define Search Directory
search_dir="KernelSU/kernel"

# Find all in the files and replace.
grep -rl 'if LINUX_VERSION_CODE < KERNEL_VERSION(4, 10, 0)' "$search_dir" | xargs sed -i 's/if LINUX_VERSION_CODE < KERNEL_VERSION(4, 10, 0)/if 1/g'
