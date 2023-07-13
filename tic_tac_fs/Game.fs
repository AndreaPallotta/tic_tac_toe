module Game

open System

type Game(p1: Player.Player, p2: Player.Player) =
    let mutable _currentPlayer: Option<Player.Player> = Some(p1)
    let mutable _winner: Option<Player.Player> = None

    member val player1: Player.Player = p1
    member val player2: Player.Player = p2
    member val board: Board.Board = Board.Board()

    member this.currentPlayer with get() = _currentPlayer and set(value) = _currentPlayer <- value
    member this.winner with get() = _winner and set(value) = _winner <- value

    member this.SwitchCurrentPlayer() =
        match this.currentPlayer with
        | Some(p) when p = p2 -> this.currentPlayer <- Some(p1)
        | Some(p) when p = p1 -> this.currentPlayer <- Some(p2)
        | _ -> ()
    
    member this.Display() =
        this.board.Display()

    member this.IsWinner() : bool =
        this.board.CheckWinner()

    member this.IsDraw() : bool =
        this.board.IsFull()

    member this.IsOver() : bool =
        if this.IsWinner() then
            this.winner <- this.currentPlayer
            this.board.SetRemainingCells()
            Utils.ClearTerminal()
            this.Display()
            match this.winner with
            | Some(winner) -> Console.WriteLine($"Game over! {winner.name} is the winner!")
            | None -> raise (new Exception("Error retrieving winner"))

            true
        elif this.IsDraw() then
            this.winner <- None
            this.currentPlayer <- None
            Console.WriteLine("Game over. It is a draw!")
            true
        else
            false

    member this.MakeMove() =
        let mutable Break = true
        match this.currentPlayer with
        | None -> raise (new Exception("Current player not found"))
        | Some (player) ->
            while Break do
                try
                    let (row, col) = Utils.GetUserInput(player.name)
                    this.board.SetCell(row, col, player.mark)
                    Break <- false
                with
                | e -> Console.WriteLine(e.Message)