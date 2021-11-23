#!/bin/bash

declare -A board

dimensions=3 #create always square board

function print_board(){
    for ((i=0; i<dimensions; i++)) do
	    echo #make new line
	    for ((j=0; j<dimensions; j++)) do
		    if [ "${board[$i,$j]}" = "0"  ]; then
			    printf "%3s" "O"
	            elif [ "${board[$i,$j]}" = "1" ]; then
			    printf "%3s" "X"
	            else
		     	    printf "%3s" "${board[$i,$j]}"
		    fi
	    done
    done
    echo #make new line
}

function init_board(){
  for ((i=0; i<dimensions; i++)) do
	for ((j=0; j<dimensions; j++)) do
		board[$i,$j]=".."
	done
  done
}

function check_end(){
  circle_win=false
  cross_win=false
  draw=false

  for((i=0; i<dimensions; i++)){
	if [[ ${board[$i,0]} == "1" && ${board[$i,1]} == "1" && ${board[$i,2]} == "1" ]]; then
	   cross_win=true
	fi
	if [[ ${board[$i,0]} == "0" && ${board[$i,1]} == "0" && ${board[$i,2]} == "0" ]]; then
	   circle_win=true
	fi
	if [[ ${board[0,$i]} == "0" && ${board[1,$i]} == "0" && ${board[2,$i]} == "0" ]]; then
	   circle_win=true
	fi
	if [[ ${board[0,$i]} == "1" && ${board[1,$i]} == "1" && ${board[2,$i]} == "1" ]]; then
	   cross_win=true
	fi
  }

  draw=true
  for ((i=0; i<dimensions; i++)) do
      for ((j=0; j<dimensions; j++)) do
	if [ ${board[$i,$j]} == ".." ]; then
	  draw=false
	fi
      done
  done

  if [ $draw == true ]; then
     echo "Remis!"
     exit 0
  fi
  
  if [ $circle_win == true ]; then
     echo "Koniec gry! Kółka wygrały."
     exit 0
  fi
  if [ $cross_win == true ]; then
     echo "Koniec gry! Krzyżyki wygrały."
     exit 0
  fi
}

function save_exit(){
  exit 0
}

echo "Witaj w grze kółko i krzyżyk!"
init_board
print_board
echo
echo "Aby wybrać pole wpisz jego współrzędne oddzielone spacją."
echo "Aby zapisać grę i wyjść wpisz 's'"

while true
do
   while true
	do
	echo -n "Gracz 1 (kółko): "
	read y x
	if [ $y == "s" ]; then
	  save_exit
        fi
	if [ ${board[$x,$y]} == ".." ]; then
	  board[$x,$y]="0"
	  break
	fi
	echo "Te pole jest już wykorzystane. Spróbuj ponownie."
   done

   print_board
   echo
   check_end

   while true
	do
	echo -n "Gracz 2 (krzyżyk): "
	read y x
	if [ $y == "s" ]; then
	  save_exit
	fi
	if [ ${board[$x,$y]} == ".." ]; then
	   board[$x,$y]="1"
	   break
	fi
	echo "Te pole jest już wykorzystane. Spróbuj ponownie."
   done

   print_board
   echo
   check_end


done	
