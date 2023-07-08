namespace tic_tac_cs
{
    interface IGame
    {
        void SwitchCurrentPlayer();
        void Display();
        bool IsWinner();
        bool IsDraw();
        bool IsOver();
        void MakeMove();
    }

    internal class Game : IGame
    {
        private Player player1;
        private Player player2;
        private Player? currentPlayer;
        private Player? winner;
        private Board board;

        public Game(Player player1, Player player2)
        {
            this.player1 = player1;
            this.player2 = player2;
            currentPlayer = player1;
            winner = null;
            board = new();
        }

        public Player? CurrentPlayer
        {
            get { return currentPlayer; }
        }

        public Player? Winner
        {
            get { return winner; }
            set { winner = value; }
        }

        public Board Board
        {
            get { return board; }
        }

        public void Display()
        {
            board.Display();
        }

        public bool IsDraw()
        {
            return board.IsFull();
        }

        public bool IsOver()
        {
            if (IsWinner())
            {
                winner = currentPlayer;
                board.SetRemainingCells();
                Utils.ClearTerminal();
                Display();
                Console.WriteLine($"Game over. {winner?.Name} is the winner!");
                return true;
            }

            if (IsDraw())
            {
                winner = null;
                currentPlayer = null;
                Console.WriteLine("Game over. It is a draw!");
                return true;
            }

            return false;
        }

        public bool IsWinner()
        {
            return board.CheckWinner();
        }

        public void MakeMove()
        {
            if (currentPlayer == null)
            {
                throw new Exception("Current player not found");
            }

            while (true)
            {
                try
                {
                    string[] input = Utils.GetUserInput(currentPlayer.Name);
                    var (row, col) = Utils.InputToCoords(input);

                    board.SetCell(row, col, currentPlayer.Mark);
                    break;
                } catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }
        }

        public void SwitchCurrentPlayer()
        {
            if (currentPlayer != null)
            {
                if (currentPlayer.Equals(player1))
                {
                    currentPlayer = player2;
                }
                else if (currentPlayer.Equals(player2))
                {
                    currentPlayer = player1;
                }
                
            }
        }
    }
}
