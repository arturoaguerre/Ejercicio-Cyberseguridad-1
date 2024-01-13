#!/bin/bash

files_directory="./PyJ Systems"

declare -A original_md5_values
original_md5_values["copia.sh"]="90965b0eb20e68b7d0b59accd2a3b4fd"
original_md5_values["log.txt"]="0b29406e348cd5f17c2fd7b47b1012f9"
original_md5_values["pass.txt"]="6d5e43a730490d75968279b6adbd79ec"
original_md5_values["plan-A.txt"]="129ea0c67567301df1e1088c9069b946"
original_md5_values["plan-B.txt"]="4e9878b1c28daf4305f17af5537f062a"
original_md5_values["script.py"]="66bb9ec43660194bc066bd8b4d35b151"

calculate_md5() {
  md5sum "$1" | awk '{print $1}'
}

output_file="output_$(date +"%Y%m%d_%H%M%S").log"

for file in "${!original_md5_values[@]}"; do

  file_path="$files_directory/$file"
  original_md5="${original_md5_values[$file]}"
	
  if [ -f "$file_path" ]; then
    calculated_md5=$(calculate_md5 "$file_path")
	
    echo "File: $file" | tee -a "$output_file"
	echo "Calculated MD5: $calculated_md5" | tee -a "$output_file"
	echo "Expected MD5:   $original_md5" | tee -a "$output_file"
	
    if [ "$calculated_md5" == "$original_md5" ]; then
      echo "Checksum for $file is valid." | tee -a "$output_file"
    else
      echo "Checksum for $file is INVALID!" | tee -a "$output_file"
    fi
  else
    echo "File $file not found." | tee -a "$output_file"
  fi
done

sleep 10