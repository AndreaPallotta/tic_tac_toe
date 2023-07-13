// For more information see https://aka.ms/fsharp-console-apps
open System


Utils.ClearTerminal()
Console.WriteLine("Welcome to Tic Tac Fs!\n")


try
    let mutable roundCounter = 0
    let mutable Break = true

    let p1Name = Utils.GetUserName(1)
    let p2Name = Utils.GetUserName(2)

    let p1 = Player.Player(p1Name, Utils.O)
    let p2 = Player.Player(p2Name, Utils.X)

    let game = Game.Game(p1, p2)
    game.Display()

    Console.WriteLine()

    while Break do
        game.MakeMove()

        roundCounter <- roundCounter + 1
        Utils.ClearTerminal()
        Console.WriteLine($"Here's the updated board. Round {roundCounter}")

        game.Display()

        if game.IsOver() = true then
            Break <- false

        if Break = true then
            game.SwitchCurrentPlayer()
            match game.currentPlayer with
            | Some(player) -> Console.WriteLine($"It is now {player.name} turn")
            | None -> raise (new Exception("Cannot find current player"))

with
    | ex -> Console.WriteLine($"An error has been found: {ex}")

