module Utils

open System

let O = "O"
let X = "X"
let DEF = "-"

let ClearTerminal() =
    Console.Write("\x1B[2J\x1B[H")

let GetUserName (playerNum: int) : string =
    let defName = $"Player {playerNum}"
    Console.Write($"Insert Player {playerNum} name (default '{defName}'): ")

    let input = Console.ReadLine().Trim()

    if String.IsNullOrEmpty(input) then
        defName
    else
        input

let GetUserInput(playerName: string) : Tuple<int, int> =
    Console.Write($"Player {playerName}, enter row and column (e.g. '1 2'): ")

    let input = Console.ReadLine().Trim()
    let inputArr = input.Split(" ")

    if inputArr.Length <> 2 then
        raise (new Exception("Invalid row or column. Try again"))
    
    try
        let row = inputArr[0] |> int
        let col = inputArr[1] |> int

        (row - 1, col - 1)
    with
    | ex -> raise (new Exception("Invalid row or column. Try again"))

let GetRow (matrix: string[,], rowNum: int) : string[] =
    [| for x in 0 .. matrix.GetLength(1) - 1 do yield matrix.[rowNum, x] |]

let GetColumn (matrix: string[,], colNum: int) : string[] =
    [| for x in 0 .. matrix.GetLength(0) - 1 do yield matrix.[x, colNum] |]


