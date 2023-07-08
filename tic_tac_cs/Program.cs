using tic_tac_cs;

Utils.ClearTerminal();
Console.WriteLine("Welcome to Tic Tac Cs!\n");

try
{
    int roundCounter = 0;

    string p1Name = Utils.GetUserName(1);
    string p2Name = Utils.GetUserName(2);

    Player p1 = new(p1Name, Mark.O);
    Player p2 = new(p2Name, Mark.X);

    Console.WriteLine();

    Game game = new(p1, p2);
    game.Display();

    while (true)
    {
        game.MakeMove();

        roundCounter++;
        Utils.ClearTerminal();
        Console.WriteLine($"Here's the updated board. Round {roundCounter}");

        game.Display();

        if (game.IsOver()) break;

        game.SwitchCurrentPlayer();
        Console.WriteLine($"It is now {game.CurrentPlayer?.Name}");
    }

}
catch (Exception ex)
{
    Console.WriteLine($"An error has been found: {ex}");
}
