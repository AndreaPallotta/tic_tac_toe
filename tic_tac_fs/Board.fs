module Board

open System

type Board() =
    let SIZE = 3
    member val cells = Array2D.create SIZE SIZE "" with get

    member this.IsValidPosition(row: int, col: int, ?fullCheck0: bool) : bool =
        let fullCheck = defaultArg fullCheck0 true
        
        if row < 0 || col < 0 || row > SIZE || col > SIZE then
            false
        else
            not fullCheck || String.IsNullOrEmpty(this.cells[row, col])

    member this.GetCell(row: int, col: int) : string =
        if not (this.IsValidPosition(row, col, false)) then
            raise (new Exception("Invalid row or column. Try again"))
        else
            this.cells[row, col]

    member this.SetCell(row: int, col: int, mark: string) = 
        if not (this.IsValidPosition(row, col)) then
            raise (new Exception("Invalid row or column. Try again"))
        else
            this.cells[row, col] <- mark

    member this.Display() =
        Console.WriteLine("\n     c1  c2  c3");
        Console.WriteLine("   -------------");

        for i in 0 .. SIZE - 1 do
            Console.Write($"r{i + 1} |");
            for j in 0 .. SIZE - 1 do
                Console.Write(String.Format(" {0,1} |", this.cells[i, j]));
            Console.WriteLine("\n   -------------")
        Console.WriteLine()

    member this.IsFull() : bool =
        let mutable isFull = true
        for i in 0 .. SIZE - 1 do
            for j in 0 .. SIZE - 1 do
                if String.IsNullOrEmpty(this.cells[i, j]) then
                    isFull <- false
        isFull

    member this.HasHorizontalWin() : bool =
        let mutable hasWin = false
        for i in 0 .. SIZE - 1 do
            let row = Utils.GetRow(this.cells, i)
            if not (Array.contains "" row) && Seq.distinct row |> Seq.length = 1 then
                hasWin <- true
        hasWin

    member this.HasVerticalWin() : bool =
        let mutable hasWin = false
        for i in 0 .. SIZE - 1 do
            let col = Utils.GetColumn(this.cells, i)
            if not (Array.contains "" col) && Seq.distinct col |> Seq.length = 1 then
                hasWin <- true
        hasWin

     member this.HasDiagonalWin() : bool =
        let mainDiagonal = [for i in 0 .. SIZE - 1 -> this.cells.[i, i]]
        let secDiagonal = [for i in 0 .. SIZE - 1 -> this.cells.[i, SIZE - i - 1]]

        let mainMatch = not (mainDiagonal |> List.contains "") && (mainDiagonal |> List.distinct |> List.length = 1)
        let secMatch = not (secDiagonal |> List.contains "") && (secDiagonal |> List.distinct |> List.length = 1)

        mainMatch || secMatch

     member this.CheckWinner() : bool =
        this.HasHorizontalWin() || this.HasVerticalWin() || this.HasDiagonalWin()

     member this.SetRemainingCells() =
        for i in 0 .. SIZE - 1 do
            for j in 0 .. SIZE - 1 do
                if String.IsNullOrEmpty(this.cells[i, j]) then
                    this.SetCell(i, j, Utils.DEF)
        
            
                    
