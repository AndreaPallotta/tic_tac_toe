Mark := Object clone
Mark O := "O"
Mark X := "X"
Mark DEF := "-"

clearTerminal := method(
  "[H[2J" print
)

getUserName := method(playerNum,
    defName := "Player " .. playerNum asString
    
    write("Insert player " .. playerNum asString .. " name (default '" .. defName .. "'): ")
    input := File standardInput readLine

    if(input == "" or input == nil,
        return defName
    )

    return input
)

getUserCoords := method(playerName,
    write("Player " .. playerName .. ", enter row and column (e.g. '1 2'): ")
    input := File standardInput readLine
    inputArr := input split(" ")

    if(inputArr size != 2,
        Exception raise("Invalid row or column. Try again")
    )

    coords := nil

    try(
        row := inputArr at(0) asNumber
        col := inputArr at(1) asNumber

        coords := list(row - 1, col - 1) 
    ) catch(_, err,
        Exception raise("Invalid row or column. Try again")
    )

    return coords
)