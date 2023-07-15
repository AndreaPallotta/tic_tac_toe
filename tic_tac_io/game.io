doFile("utils.io")

Game := Object clone
Game board := Board clone
Game player1 := nil
Game player2 := nil
Game currentPlayer := nil
Game winner := nil

Game create := method(player1, player2,
    self player1 = p1
    self player2 = p2
    self currentPlayer = p1
)

Game switchCurrentPlayer := method(
    if(currentPlayer == nil,
        Exception raise("Cannot find current player")
    )


    if(currentPlayer == player1,
        currentPlayer = player2
        return
    ) 
    if(currentPlayer == player2,
        currentPlayer = player1
        return
    )
)

Game display := method(
    board display()
)

Game isWinner := method(
    return board checkWinner()
)

Game isDraw := method(
    return board isFull()
)

Game isOver := method(
    if(isWinner() == true,
        if(currentPlayer == nil,
            Exception raise("Cannot find current player")
        )
        winner = currentPlayer
        board setRemainingCells()
        clearTerminal()
        display()
        write("Game over! " .. currentPlayer name .. " is the winner!")
        return true
    ) elseif(isDraw() == true,
        winner = nil
        currentPlayer = nil
        writeln("Game over! It is a draw!")
        return true
    )

    return false
)

Game makeMove := method(
    loop := true
    if(currentPlayer == nil,
        Exception raise("Current player not found!")
    )
    while(loop,
        e := try(
            coords := getUserCoords(currentPlayer name)
            board setCell(coords at(0), coords at(1), currentPlayer mark)
            loop = false
        )

        e catch(
            writeln(e error)
        )
    )
)