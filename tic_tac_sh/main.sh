#!/usr/bin/env bash

# ========== VARIABLES ==========

board=(" " " " " " " " " " " " " " " " " ")
MARK_O="O"
MARK_X="X"
player_names=()

# ========== END OF VARIABLES ==========

# ========== FUNCTION ==========

clear_terminal() {
    printf "\033c"
}

all_equals() {
    local arr=("$@")
    local first=${arr[0]}

    for item in "${arr[@]}"; do
        if [[ "${item}" != "${first}" ]]; then
            return 1
        fi
    done

    if [[ -z "${first// }" ]]; then
        return 1
    fi

    return 0
}

get_player_name() {
    local def_name="$1"
    local player_num="$2"
    local input

    while true; do
        read -rp "Insert Player $player_num name (default '$def_name'): " -e -i "$def_name" input
        input="${input%[[:space:]]}"

        if [[ -z "$input" ]]; then
            input="$def_name"
        fi

        if ! [[ " ${player_names[*]} " =~ " ${input} " ]]; then
            break
        else
            echo "Name '$input' is already taken. Please choose a different name."
        fi
    done

    player_names+=("$input")
    echo "$input"
}

display_board() {
    clear_terminal
    echo "r1  | ${board[0]} | ${board[1]} | ${board[2]} |"
    echo "    -------------"
    echo "r2  | ${board[3]} | ${board[4]} | ${board[5]} |"
    echo "    -------------"
    echo "r3  | ${board[6]} | ${board[7]} | ${board[8]} |"
    echo "    -------------"
}

has_horizontal_win() {
    for row in "${board[@]}"; do
        local row_arr=("$row")

        if all_equals "${row_arr[@]}"; then
            return 0
        fi
    done

    return 1
}

has_vertical_win() {
    for ((i = 0; i < 3; i++)); do
        local col=()
        for row in "${board[@]}"; do
            local cell="${row:i:1}"
            col+=("$cell")
        done

        if all_equals "${col[@]}"; then
            return 0
        fi
    done

    return 1
}

has_diagonal_win() {
    local diagonals=()

    diagonals+=("${board[0]::1}${board[1]:1:1}${board[2]:2:1}")
    diagonals+=("${board[0]:2:1}${board[1]:1:1}${board[2]::1}")

    if all_equals "${diagonals[0]}" || all_equals "${diagonals[1]}"; then
        return 0
    fi

    return 1
}

check_winner() {
    if has_horizontal_win || has_vertical_win || has_diagonal_win; then
        return 0
    fi

    return 1
}

is_board_full() {
    for cell in "${board[@]}"; do
        if [ "$cell" == " " ]; then
            return 1
        fi
    done

    return 0
}

initialize_player() {
    local name="$1"
    local mark="$2"
    local IFS='|'
    local player=("$name" "$mark")

    echo "${player[*]}"
}

get_name() {
    local player=("$@")
    
    if [ "${#player[@]}" -ge 2 ]; then
        local IFS='|'
        echo "${player[0]}"
    else
        echo "Invalid user"
    fi
}

get_mark() {
    local player=("$@")

    if [ "${#player[@]}" -ge 2 ]; then
        local IFS='|'
        echo "${player[1]}"
    else
        echo "Invalid user"
    fi
}

toggle_cp() {
    local p1_name="$1"
    local p1_symbol="$2"
    local p2_name="$3"
    local p2_symbol="$4"
    local cp_name="$5"
    local cp_symbol="$6"


}

# ========== END OF FUNCTIONS ==========

# ========== MAIN ==========

main() {
    local p1_name=$(get_player_name "Player 1" 1)
    local p2_name=$(get_player_name "Player 2" 2)

    IFS='|' read -ra p1 <<< "$(initialize_player "$p1_name" "$MARK_O")"
    IFS='|' read -ra p2 <<< "$(initialize_player "$p2_name" "$MARK_X")"

    local cp=("${p1[@]}")

    # get_name "${cp[@]}"
    # cp=($(toggle_cp "${p1[@]}" "${p2[@]}" "${cp[@]}"))
    # echo "${cp[@]}"
    # get_name "${cp[@]}"

    # total_moves=0

    # while true; do
    #     display_board
    # done
}

clear_terminal
echo "Welcome to Tic Tac Sh!"

main

# ========== END OF MAIN ==========