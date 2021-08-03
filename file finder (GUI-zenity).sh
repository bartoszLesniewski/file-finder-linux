#!/bin/bash
OPTION=0
WINDOW_DIMENSIONS="--width 400 --height 120"
while [[ $OPTION != "Koniec" ]]; do
    MENU=("Nazwa pliku: $NAME" "Katalog: $DIRECTORY" "Właściciel: $OWNER" "Maksymalny rozmiar (w MB): $SIZE" "Ostatnia modyfikacja wcześniej niż [N] dni temu: $LAST_MOD_TIME" "Zawartość pliku: $CONTENT" "Szukaj" "Koniec")
    OPTION=`zenity --list --column=Menu "${MENU[@]}" --width 600 --height 300`
    case "$OPTION" in
	"${MENU[0]}")
	    NAME=`zenity --entry --title "Nazwa pliku" --text "Podaj nazwę pliku" $WINDOW_DIMENSIONS`
	    if [[ -n $NAME ]]; then
		FIND_NAME="-name \"$NAME\""
	    else
		FIND_NAME=""
	    fi
	    ;;
	"${MENU[1]}")
	    DIRECTORY=`zenity --entry --title "Nazwa katalogu" --text "Podaj nazwę katalogu" $WINDOW_DIMENSIONS`
	    if [[ -n $DIRECTORY ]]; then
		FIND_DIRECTORY=$DIRECTORY
	    else
		FIND_DIRECTORY=""
	    fi
	    ;;
	"${MENU[2]}")
	    OWNER=`zenity --entry --title "Właściciel pliku" --text "Podaj właściciela pliku" $WINDOW_DIMENSIONS`
	    if [[ -n $OWNER ]]; then
		FIND_OWNER="-user \"$OWNER\""
	    else
		FIND_OWNER=""
	    fi
	    ;;
        "${MENU[3]}")
	    SIZE=`zenity --scale --text "Podaj rozmiar pliku w MB" --min-value 1 --max-value 500 --value 250`
	    if [[ -n $SIZE ]]; then
		FIND_SIZE="-size -${SIZE}M"
	    else
		FIND_SIZE=""
	    fi
	    ;;
	"${MENU[4]}")
	    LAST_MOD_TIME=`zenity --scale --text "Podaj maksymalną liczbę dni, jakie upłynęły od ostatniej modyfikacji" --min-value 1 --max-value 366 --value 7`
	    if [[ -n $LAST_MOD_TIME ]]; then
		FIND_LAST_MOD_TIME="-mtime -$LAST_MOD_TIME"
	    else
		FIND_LAST_MOD_TIME=""
	    fi
	    ;;
        "${MENU[5]}")
	    CONTENT=`zenity --entry --title "Zawartość pliku" --text "Podaj zawartość pliku" $WINDOW_DIMENSIONS`
	    if [[ -n $CONTENT ]]; then
		FIND_CONTENT="-exec grep -li \"$CONTENT\" {} +"
	    else
		FIND_CONTENT=""
	    fi
	    ;;
        "${MENU[6]}")
	    eval "find $FIND_DIRECTORY -type f $FIND_NAME $FIND_OWNER $FIND_SIZE $FIND_LAST_MOD_TIME $FIND_CONTENT" | zenity --text-info --width 600 --height 400 --title "Wyniki wyszukiwania"
	    ;;
    esac
done
