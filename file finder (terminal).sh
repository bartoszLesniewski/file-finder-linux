#!/bin/bash
OPTION=0
echo -n `clear`
while [[ $OPTION -ne 8 ]]; do    
    echo "1. Nazwa pliku: $NAME"
    echo "2. Katalog: $DIRECTORY"
    echo "3. Właściciel: $OWNER"
    echo "4. Maksymalny rozmiar (w MB): $SIZE"
    echo "5. Ostatnia modyfikacja wcześniej niż [N] dni temu: $LAST_MOD_TIME"
    echo "6. Zawartość pliku: $CONTENT"
    echo "7. Szukaj"
    echo "8. Koniec" 
    echo -n "Wpisz cyfrę odpowiadającą opcji, którą chcesz wybrać: "
    read OPTION
    case "$OPTION" in
	"1")
	    echo -n "`clear`Podaj nazwę pliku: "
	    read NAME
	    if [[ -n $NAME ]]; then
		FIND_NAME="-name \"$NAME\""
	    else
		FIND_NAME=""
	    fi
	    echo -n `clear`
	    ;;
	"2")
	    echo -n "`clear`Podaj nazwę katalogu: "
	    read DIRECTORY
	    if [[ -n $DIRECTORY ]]; then
		FIND_DIRECTORY=$DIRECTORY
	    else
		FIND_DIRECTORY=""
	    fi
	    echo -n `clear`
	    ;;
	"3")
	    echo -n "`clear`Podaj właściciela pliku: "
	    read OWNER
	    if [[ -n $OWNER ]]; then
		FIND_OWNER="-user \"$OWNER\""
	    else
		FIND_OWNER=""
	    fi
	    echo -n `clear`
	    ;;
	"4")
	    echo -n "`clear`Podaj liczbę (bez jednostki) odpowiadającą rozmiarowi pliku w MB: "
	    read SIZE
	    if [[ -n $SIZE ]]; then
		FIND_SIZE="-size -${SIZE}M"
	    else
		FIND_SIZE=""
	    fi
	    echo -n `clear`
	    ;;
	"5")
	    echo -n "`clear`Podaj maksymalną liczbę dni, jakie upłynęły od ostatniej modyfikacji: "
	    read LAST_MOD_TIME
	    if [[ -n $LAST_MOD_TIME ]]; then
		FIND_LAST_MOD_TIME="-mtime -$LAST_MOD_TIME"
	    else
		FIND_LAST_MOD_TIME=""
	    fi
	    echo -n `clear`
	    ;;
	"6")
	    echo -n "`clear`Podaj zawartość pliku: "
	    read CONTENT
	    if [[ -n $CONTENT ]]; then
		FIND_CONTENT="-exec grep -li \"$CONTENT\" {} +"
	    else
		FIND_CONTENT=""
	    fi
	    echo -n `clear`
	    ;;
	"7")
	    echo "`clear`Wyniki wyszukiwania:"
	    eval "find $FIND_DIRECTORY -type f $FIND_NAME $FIND_OWNER $FIND_SIZE $FIND_LAST_MOD_TIME $FIND_CONTENT"
	    echo 
	    ;;
    esac
done
