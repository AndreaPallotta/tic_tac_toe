#!/usr/bin/env io

doFile("utils.io")

clearTerminal()
writeln("Welcome to Tic Tac Io \n")

e := try(
    roundCounter := 1
    loop := true

    p1Name := getUserName(1)
    p2Name := getUserName(2)

    p1 := Player clone
    p2 := Player clone
    p1 create(p1Name, Mark O)
    p2 create(p2Name, Mark X)

    writeln("")

    game := Game clone
    game create(p1, p2)

    game display()

    while(loop,
        game makeMove()

        roundCounter = roundCounter + 1
        clearTerminal()

        writeln("Here's the updated board. Round " .. roundCounter asString)

        game display()
        if (game isOver() == true,
            writeln()
        loop := false)

        game switchCurrentPlayer()

        writeln("It is now " .. game currentPlayer name .. " turn!")
    )
)

e catch(
    writeln("An error has been found: ", e error)
)

writeln("")