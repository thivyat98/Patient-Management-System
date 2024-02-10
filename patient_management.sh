#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

 
clear_screen() {
  clear
}


list_patients() {
  clear_screen
  echo -e "${BLUE}Listing all patients...${RESET}\n"
  sort -t',' -k2,2 -k3,3 -k4,4 -k1,1 patients.csv | tr ',' '\t' | tr 'a-z' 'A-Z'
}


add_patient() {
  clear_screen
  echo -e "${CYAN}Add a new patient:${RESET}"
  read -p "Enter first name: " first_name
  read -p "Enter last name: " last_name
  read -p "Enter phone number: " phone_number


  patient_id="${last_name:0:4}${first_name:0:1}"
  

  counter=2
  while grep -q "^${patient_id}$" patients.csv; do
    patient_id="${last_name:0:4}${first_name:0:1}${counter}"
    counter=$((counter + 1))
  done

  echo "${patient_id},${first_name},${last_name},${phone_number}" >> patients.csv

  clear_screen
  echo -e "${GREEN}Thanks for entering the new patient information...${RESET}"
  echo -e "The new ${YELLOW}Patient ID is ${patient_id}${RESET}"
  echo -e "The new patient is added to the patient records.\n"
}

search_patient() {
  clear_screen
  read -p "Enter the last name to search: " search_term
  echo -e "${BLUE}Here are the matching records...${RESET}\n"

  grep -i "${search_term}" patients.csv | tr ',' '\t' | tr 'a-z' 'A-Z' | sort -t$'\t' -k2,2
}

delete_patient() {
  clear_screen
  read -p "Enter the last name to delete: " delete_term
  grep -v -i "${delete_term}" patients.csv > temp.csv
  mv temp.csv patients.csv
 echo -e "${RED}Matching records deleted.${RESET}\n" 
}


while true; do
  clear_screen
  echo -e "${GREEN}Welcome to the ${BLUE}Patient Management System ${GREEN}of ${YELLOW}Hospital X...${RESET}"
  echo -e "[${YELLOW}L/l${RESET}] ${BLUE}List patients${RESET}"
  echo -e "[${YELLOW}A/a${RESET}] ${CYAN}Add a new patient${RESET}"
  echo -e "[${YELLOW}S/s${RESET}] ${BLUE}Search patient${RESET}"
  echo -e "[${YELLOW}D/d${RESET}] ${RED}Delete patient${RESET}"
  echo -e "[${YELLOW}E/e${RESET}] ${RED}Exit${RESET}"
  read -p "Select an option: " choice

  case $choice in
    [Ll]) list_patients ;;
    [Aa]) add_patient ;;
    [Ss]) search_patient ;;
    [Dd]) delete_patient ;;
    [Ee])
      clear_screen
      echo -e "${YELLOW}Thank you for using this app.Goodbye!${RESET}"
      exit 0
      ;;
    *) echo -e "${RED}Invalid option. Please try again.${RESET}" ;;
  esac

  read -p "Press Enter to continue..."
done
