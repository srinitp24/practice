#!/bin/bash

extensions=(txt json yaml yml)
words=("apple" "banana" "orange" "grape" "kiwi" "peach" "strawberry" "blueberry" "pineapple" "watermelon")

# Function to list files with .json and .yaml extensions
list_json_yaml_files() {
    echo "List of .json and .yaml files:"
    ls *.json *.yaml 2>/dev/null || echo "No .json or .yaml files found"
}

# Function to check and rename .yaml files to .yml
rename_yaml_to_yml() {
    for file in file_*.yaml; do
        if [ -f "$file" ]; then
            new_name="${file%.yaml}.yml"
            mv "$file" "$new_name"
            echo "Renamed $file to $new_name"
        fi
    done
}

# Function to generate human-readable string
generate_human_readable_string() {
    rand_str=""
    for i in {1..3}; do
        rand_index=$((RANDOM % ${#words[@]}))
        rand_word="${words[$rand_index]}"
        rand_str="$rand_str$rand_word"
    done
    echo "$rand_str"
}

# Function to move files containing "success" to a "success" folder
# and move the rest to an "archive" folder
move_files() {
    mkdir -p success archive  # Create folders if they don't exist
    for file in file_*; do
        if grep -q "success" "$file"; then
            mv "$file" success/
            echo "Moved $file to success/"
        else
            mv "$file" archive/
            echo "Moved $file to archive/"
        fi
    done
}



# Loop to create 10 files with random extensions
for i in {1..10}; do
    random_extension=${extensions[$RANDOM % ${#extensions[@]}]}
    touch "file_$i.$random_extension"
    echo "Created file_$i.$random_extension"

    if [ $i -le 4 ]; then
        echo "success" > "file_$i.$random_extension"
    else
        # Generating human-readable string
        random_string=$(generate_human_readable_string)
        echo "$random_string" > "file_$i.$random_extension"
    fi
done

# Call function to list .json and .yaml files
list_json_yaml_files

# Call function to rename .yaml to .yml
rename_yaml_to_yml

# Call function to move files containing "success" to "success" folder
# and the rest to "archive" folder
move_files

