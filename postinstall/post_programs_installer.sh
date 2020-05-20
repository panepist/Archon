#!/bin/bash
#
#
# Archon -- Ελληνικός Arch Linux Installer
# Copyright (c)2017 Vasilis Niakas, Salih Emin and Contributors
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation version 3 of the License.
#
# Please read the file LICENSE, README and AUTHORS for more information.
#
#

# Exit codes για success || failure
#
# setfont gr928a-8x16.psfu
OK=0
NOT_OK=1
INTERNET_CONNECTION_ERROR=2

# A few colors
#
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
ICyan='\033[0;96m'        # Not used yet Cyan
IBlue='\033[0;94m'        # Blue
NC='\033[0m'              # No Color

#  Check Net Connection | If it is off , exit immediately
#
function check_net_connection() {
    sleep 1
    echo '---------------------------------------'
    echo ' Έλεγχος σύνδεσης στο διαδίκτυο        '
    echo '---------------------------------------'
    if ping -c 3 www.google.com &> /dev/null; then
        echo -e "${IYellow} Η σύνδεση στο διαδίκτυο φαίνεται ενεργοποιημένη...Προχωράμε...\n${NC}"
        return $OK
    else
        echo -e "${IRed} Η σύνδεση στο Διαδίκτυο φαίνεται απενεργοποιημένη ... Ματαίωση ...\n"
        echo -e "Συνδεθείτε στο Διαδίκτυο και δοκιμάστε ξανά ... \n Ματαίωση...${NC}"
        return $INTERNET_CONNECTION_ERROR
    fi
}


# Install a music player | For now #2 options : Clementine | Audacious
#
function install_music_player() {
    echo -e "${IGreen}Επιλέξτε ένα από τα επόμενα προγράμματα αναπαραγωγής μουσικής : \n"
    echo -e "'1'  για  Clementine  Music  Player \n"
    echo -e "'2'  για  Audacious   Music  Player \n"
    
    read -p "Γράψτε την επιλογή σας [1, 2 ή exit] >>> " mp_choice

    if [[ $mp_choice =~ [1-2] ]] || [[ $mp_choice == "exit" ]]
    then
        case "$mp_choice" in
			1)
                echo -e "${IBlue} \nΕγκατάσταση Clementine Music Player ... ${NC}\n"
                if pacman -S clementine
                then
                    # Sweet, installed clementine
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση Clementine Music Player  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during clementine installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση Clementine Music Player  ... ${NC}\n"
                    return $NOT_OK
                fi
				;;
			2)
                echo -e "${IBlue} \nΕγκατάσταση Audacious Music Player ... ${NC}\n"
                if pacman -S audacious
                then
                    # Sweet, installed audacious
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση Audacious Music Player  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during audacious installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση Audacious Music Player  ... ${NC}\n"
                    return $NOT_OK
                fi
                ;;
            exit)
                echo -e "${ICyan}\n Έξοδος όπως επιλέχθηκε από τον χρήστη: '${USER}' ...\n${NC}"
                return $OK
                ;;
            *)
                echo -e "${ICyan}\nΟι επιλογές σας πρέπε να είναι [1 ή 2]. Παρακαλώ προσπάθησε ξανά τώρα!\n${NC}"
                sleep 3
                clear
                install_music_player
                ;;
        esac
    else
        echo -e "${ICyan}\nΟι επιλογές σας ήταν [1 ή 2]. ΠΑΡΑΚΑΛΩ προσπάθησε ξανά!\n${NC}"
        sleep 3
        clear
        install_music_player
    fi
    return $OK
}

# Install a media player | For now #2 options : VLC | MPV
#
function install_media_player() {
    echo -e "${IGreen}Επιλέξτε ένα από τα επόμενα προγράμματα αναπαραγωγής πολυμέσων : \n"
    echo -e "'1'  για  VLC   Media  Player \n"
    echo -e "'2'  για  MPV   Media  Player \n"
    
    read -p "Γράψτε την επιλογή σας [1, 2 ή exit] >>> " mp_choice

    if [[ $mp_choice =~ [1-2] ]] || [[ $mp_choice == "exit" ]]
    then
        case "$mp_choice" in
			1)
                echo -e "${IBlue} \nΕγκατάσταση VLC Media Player ... ${NC}\n"
                if pacman -S vlc
                then
                    # Sweet, installed clementine
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση VLC Media Player  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during clementine installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση VLC Media Player  ... ${NC}\n"
                    return $NOT_OK
                fi
				;;
			2)
                echo -e "${IBlue} \nΕγκατάσταση MPV Media Player ... ${NC}\n"
                if pacman -S mpv
                then
                    # Sweet, installed audacious
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση MPV Media Player  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during audacious installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση MPV Media Player  ... ${NC}\n"
                    return $NOT_OK
                fi
                ;;
            exit)
                echo -e "${ICyan}\n Έξοδος όπως επιλέχθηκε από τον χρήστη: '${USER}' ...\n${NC}"
                return $OK
                ;;
            *)
                echo -e "${ICyan}\nΟι επιλογές σας πρέπε να είναι [1 ή 2]. Παρακαλώ προσπάθησε ξανά τώρα! ... \n${NC}"
                sleep 3
                clear
                install_media_player
                ;;
        esac
    else
        echo -e "${ICyan}\nΟι επιλογές σας ήταν [1 ή 2]. ΠΑΡΑΚΑΛΩ προσπάθησε ξανά! ...\n${NC}"
        sleep 3
        clear
        install_media_player
    fi
    return $OK
}

# Install an Internet Explorer in Arch Linux | #2 Options for now : Firefox | Chromium
#
function install_net_explorer() {
    echo -e "${IGreen}Επιλέξτε ένα από τα επόμενα προγράμματα περιήγησης στο Διαδίκτυο : \n"
    echo -e "'1'  για  Firefox  Web Browser \n"
    echo -e "'2'  για  Chromium Web Browser \n"
    
    read -p "Γράψτε την επιλογή σας [1, 2 ή exit] >>> " ne_choice

    if [[ $ne_choice =~ [1-2] ]] || [[ $ne_choice == "exit" ]]
    then
        case "$ne_choice" in
			1)
                echo -e "${IBlue} \nΕγκατάσταση Firefox ... ${NC}\n"
                if pacman -S firefox
                then
                    # Sweet, installed Firefox
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση Firefox  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during Firefox installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση Firefox  ... ${NC}\n"
                    return $NOT_OK
                fi
				;;
			2)
                echo -e "${IBlue} \nΕγκατάσταση Chromium ... ${NC}\n"
                if pacman -S chromium
                then
                    # Sweet, installed Chromium
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση Chromium  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during Chromium installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση Chromium  ... ${NC}\n"
                    return $NOT_OK
                fi
                ;;
            exit)
                echo -e "${ICyan}\n Έξοδος όπως επιλέχθηκε από τον χρήστη: '${USER}' ...\n${NC}"
                return $OK
                ;;
            *)
                echo -e "${ICyan}\nΟι επιλογές σας πρέπε να είναι [1 ή 2]. Παρακαλώ προσπάθησε ξανά τώρα! ... \n${NC}"
                sleep 3
                clear
                install_net_explorer
                ;;
        esac
    else
        echo -e "${ICyan}\nΟι επιλογές σας ήταν [1 ή 2]. ΠΑΡΑΚΑΛΩ προσπάθησε ξανά! ...\n${NC}"
        sleep 3
        clear
        install_net_explorer
    fi
    return $OK
}

# Install an Email Client in Arch Linux | #2 Options for now : Thunderbird | Evolution
#
function install_email_client() {
    echo -e "${IGreen}Επιλέξτε έναν από τους επόμενους πελάτες ηλεκτρονικού ταχυδρομίου : \n"
    echo -e "'1'  για  Thunderbird  Email Client \n"
    echo -e "'2'  για  Evolution    Email Client \n"
    
    read -p "Γράψτε την επιλογή σας [1, 2 ή exit] >>> " ec_choice

    if [[ $ec_choice =~ [1-2] ]] || [[ $ec_choice == "exit" ]]
    then
        case "$ec_choice" in
			1)
                echo -e "${IBlue} \nΕγκατάσταση Thunderbird ... ${NC}\n"
                if pacman -S thunderbird
                then
                    # Sweet, installed Thunderbird
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση Thunderbird  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during Thunderbird installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση Thunderbird  ... ${NC}\n"
                    return $NOT_OK
                fi
				;;
			2)
                echo -e "${IBlue} \nΕγκατάσταση Evolution ... ${NC}\n"
                if pacman -S evolution
                then
                    # Sweet, installed Evolution
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση Evolution  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during Evolution installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση Evolution  ... ${NC}\n"
                    return $NOT_OK
                fi
                ;;
            exit)
                echo -e "${ICyan}\n Έξοδος όπως επιλέχθηκε από τον χρήστη: '${USER}' ...\n${NC}"
                return $OK
                ;;
            *)
                echo -e "${ICyan}\nΟι επιλογές σας πρέπε να είναι [1 ή 2]. Παρακαλώ προσπάθησε ξανά τώρα! ... \n${NC}"
                sleep 3
                clear
                install_email_client
                ;;
        esac
    else
        echo -e "${ICyan}\nΟι επιλογές σας ήταν [1 ή 2]. ΠΑΡΑΚΑΛΩ προσπάθησε ξανά! ...\n${NC}"
        sleep 3
        clear
        install_email_client
    fi
    return $OK
}

# Install a Text/Code Editor : Visual Studio Code (Open Source) | Atom
#
function install_text_editor() {
    echo -e "${IGreen}Επιλέξτε έναν από τους επόμενους επεξεργαστές κειμένου : \n"
    echo -e "'1'  για  Visual Studio Code (Open Source) \n"
    echo -e "'2'  για  Atom   Text   Editor \n"
    
    read -p "Γράψτε την επιλογή σας [1, 2 ή exit] >>> " te_choice

    if [[ $te_choice =~ [1-2] ]] || [[ $te_choice == "exit" ]]
    then
        case "$te_choice" in
			1)
                echo -e "${IBlue} \nΕγκατάσταση  ... ${NC}\n"
                if pacman -S code
                then
                    # Sweet, installed Visual Studio Code (code)
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση Visual Studio Code  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during Visual Studio Code installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση Visual Studio Code  ... ${NC}\n"
                    return $NOT_OK
                fi
				;;
			2)
                echo -e "${IBlue} \nΕγκατάσταση Atom Text Editor ... ${NC}\n"
                if pacman -S atom
                then
                    # Sweet, installed Atom Text Editor
                    echo -e "${IYellow} \n[ ΕΓΙΝΕ ] Εγκατάσταση Atom Text Editor  ... ${NC}\n"
                    return $OK
                else
                    # Oops, failure during Atom Text Editor installation
                    echo -e "${IRed} \n[ ΑΠΟΤΥΧΙΑ ] Εγκατάσταση Atom Text Editor  ... ${NC}\n"
                    return $NOT_OK
                fi
                ;;
            exit)
                echo -e "${ICyan}\n Έξοδος όπως επιλέχθηκε από τον χρήστη: '${USER}' ...\n${NC}"
                return $OK
                ;;
            *)
                echo -e "${ICyan}\nΟι επιλογές σας πρέπε να είναι [1 ή 2]. Παρακαλώ προσπάθησε ξανά τώρα! ... \n${NC}"
                sleep 3
                clear
                install_text_editor
                ;;
        esac
    else
        echo -e "${ICyan}\nΟι επιλογές σας ήταν [1 ή 2]. ΠΑΡΑΚΑΛΩ προσπάθησε ξανά! ...\n${NC}"
        sleep 3
        clear
        install_text_editor
    fi
    return $OK
}


# Helping function in order to continue main procedure or not
#
function continue_or_not_check() {
    echo -e "${ICyan} Θα θέλατε να συνεχίσετε με την εγκατάσταση προγράμματος $1 ? :\n"
    echo -e " Πληκτρολογήστε 'y' για ΝΑΙ 'Η 'n' για ΟΧΙ :\n"      
    read -p "Γράψτε την επιλογή σας [ y | n ] >>> " continue_or_not
    if [ "$continue_or_not" == "y" ]
    then
        echo -e "${ICyan}Προχωράμε με την εγκατάσταση $1 ... ${NC}\n"
    else
        echo -e "${IRed}Έξοδος μετά από επιλογή του υπερ-χρήστη '$USER' ...${NC}\n"
        exit $OK
    fi
}


function main() {
    # If user is not the super-user, then abort
    #
    if [ $UID -ne $OK ]
    then
        echo -e "${IRed} Γίνετε root μέσω του 'sudo -s' | 'sudo -i' | 'su' εντολών και δοκιμάστε ξανά ... ${NC}"
        exit $NOT_OK
    else
        check_net_connection
        if [ $? -eq $INTERNET_CONNECTION_ERROR ]
        then
            echo -e "${IRed} Συνδεθείτε στο διαδίκτυο και προσπαθήστε ξανά. ${NC}\n"
            exit $NOT_OK
        else
            echo -e "${ICyan} Ξεκινάμε με την εγκατάσταση ενός Music Player ...${NC}\n"
            # 1st: Install a Music Player
            #
            install_music_player
            #
            # Perform a check : User wishes to continue OR NOT ??
            #
            continue_or_not_check "Πολυμέσων (Media Player) "
            # 2nd: Install A Media Player
            #
            install_media_player
            #
            # Perform a check : User wishes to continue OR NOT ??
            #
            continue_or_not_check "περιήγησης στο Διαδίκτυο (Internet Explorer) "
            # 3rd : Install a Web Browser
            #
            install_net_explorer
            #
            # Perform a check : User wishes to continue OR NOT ??
            #
            continue_or_not_check "διαχείρησης Ηλεκτρονικού ταχυδρομίου (Email Client) "
            # 4th : Install an Email Client
            #
            install_email_client
            #
            # Perform a check : User wishes to continue OR NOT ??
            #
            continue_or_not_check " Επεξεργασίας κειμένου (Text Editor) "
            # 5th : Install a Text/Code Editor
            #
            install_text_editor
        fi
    fi
}


#############
### MAIN ###
###########

# Start main function
#
main