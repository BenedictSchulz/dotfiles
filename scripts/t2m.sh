#! /bin/bash

old_ext=".txt"
new_ext=".md"

# takes first input argument and stores it into variable 
input_file="$1"

# Removes path and old extension
file_name=$(basename "$input_file" "$old_ext")

# Copies Content and creates new file with filename and new extension added
cp "$input_file" "${file_name}${new_ext}"


