#!/bin/bash

NO_RE='^[0-9]+$'
copies="${1:-1}"

while (( $copies > 0 )); do 
  for f in ./*.pdf;
  do 
    if [[ ! -f "$f" ]]; then
      echo "Not PDFs found."
      exit 1
    fi
    echo "Printing $f for $copies time(s) ..."
    lpr -o sides=two-sided-long-edge -o CNCopies=$copies -o Collate=StapleCollate -o StapleLocation=TopLeft -P Canon-iR-ADV-C5535-5540-UFR-II "$f"
  done
  copies=1

  read -r -p "Everything printed. Do you want to delete the files or print further copies? [Y/n/1-9] " response
  if ! [[ $response =~ ^[0-9]$ ]] ; then
    response=${response,,}    # tolower
    if ! [[ "$response" =~ ^(no|n)$ ]]; then
      echo "Deleting PFDs ..."
      rm -rf ./*.pdf
    fi
    echo "Done!"
    exit 0
  fi

  copies=$response
done


