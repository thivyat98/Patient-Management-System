#!/bin/bash

declare -a patients

list_patients() {
   if [ ${#patients[@]} -eq 0 ]; then
     echo "No patients found."
   else
     echo "List of Patients:"
     for patient in "${patients[@]}"; do
        echo "$patient"
     done
  fi
}

add_patient() {
    read -p "Enter patient ID: " patient_id
    read -p "Enter first name: " first_name
    read -p "Enter last name: " last_name
    read -p "Enter phone number: " phone_number 

    patient_record="$patient_id,$first_name,$last_name,$phone_number"
    patients+=("$patient_record")

    echo "Patient added successfully."
}

search_patient() {
    read -p "Enter patient ID to search: " search_id

    for patient in "${patients[@]}"; do
       if [[ $patient == *"$search_id,"* ]]; then 
           echo "Patient found: $patient"
           return
       fi
    done
    echo "Patient not found."
}

delete_patient() {
    read -p "Enter patient ID to delete: " delete_id

    for i in "${!patients[@]}"; do
        if [[ ${patients[i]} == *"$delete_id,"* ]]; then
            unset 'patients[i]'
            patients=("${patients[@]}")
            echo "Patient with ID $delete_id deleted."
            return
         fi
     done

 
     echo "Patient not found."
}
 



 
clear
echo "Welcome to the Patient Management System of Hospital X"
echo

while true; do
    echo "Main Menu: "
    echo "[L/l] List patients"
    echo "[A/a] Add a new patient"
    echo "[S/s] Search patient"
    echo "[D/d] Delete patient"
    echo "[E/e] Exit"
    echo
    
    read -p "Select an option: " choice
    echo

    choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

    case "$choice" in
        1)
           list_patients
           ;;
        a)
           add_patient
           ;;
        s)
           search_patient
           ;;
        d)
           delete_patient
           ;;
        e)
           echo "Exiting the Patient Management System. Goodbye!"
           exit 0
           ;;
        *)
           echo "Invalid option. Please select a valid option."
           ;;
    esac
 done 
 
