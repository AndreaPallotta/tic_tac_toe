namespace tic_tac_cs
{
    interface IBoard
    {
        string[,] GetCells();
        bool IsValidPosition(int row, int col, bool fullCheck);
        string GetCell(int row, int col);
        void SetCell(int row, int col, string mark);
        void Display();
        bool IsFull();
        bool HasHorizontalWin();
        bool HasVerticalWin();
        bool HasDiagonalWin();
        bool CheckWinner();
        void SetRemainingCells();

    }

    internal class Board : IBoard
    {
        public const int SIZE = 3;
        private string[,] cells;

        public Board()
        {
            cells = new string[SIZE, SIZE];
            for (int i = 0; i < SIZE; i++)
            {
                for (int j = 0; j < SIZE; j++)
                {
                    cells[i, j] = string.Empty;
                }
            }
        }

        public string[,] GetCells()
        {
            return cells;
        }

        public bool CheckWinner()
        {
            return HasHorizontalWin() || HasVerticalWin() || HasDiagonalWin();
        }

        public void Display()
        {
            Console.WriteLine();
            Console.WriteLine("     c1  c2  c3");
            Console.WriteLine("    ------------");

            for (int i = 0; i < SIZE; i++)
            {
                Console.Write($"r{i + 1} |");
                for (int j = 0; j < SIZE; j++)
                {
                    Console.Write(string.Format(" {0,1} |", cells[i, j]));
                }

                Console.WriteLine();
                Console.WriteLine("   -------------");
            }

            Console.WriteLine();
        }

        public string GetCell(int row, int col)
        {
            if (!IsValidPosition(row, col, false))
            {
                throw new Exception("Invalid row or column value. Try again");
            }

            return cells[row, col];
        }

        public bool HasDiagonalWin()
        {
            List<string> mainDiagonal = new List<string>();
            List<string> secDiagonal = new List<string>();

            for (int i = 0; i < SIZE; i++)
            {
                mainDiagonal.Add(cells[i, i]);
                secDiagonal.Add(cells[i, SIZE - i - 1]);
            }

            bool mainMatch = !mainDiagonal.Contains("") && mainDiagonal.Distinct().Count() == 1;
            bool secMatch = !secDiagonal.Contains("") && secDiagonal.Distinct().Count() == 1;

            return mainMatch || secMatch;
        }

        public bool HasHorizontalWin()
        {
            for (int i = 0; i < SIZE; i++)
            {
                string[] row = Utils.GetRow(cells, i);

                if (!row.Contains("") && row.Distinct().Count() == 1)
                {
                    return true;
                }
            }

            return false;
        }

        public bool HasVerticalWin()
        {
            for (int i = 0; i < SIZE; i++)
            {
                string[] col = Utils.GetColumn(cells, i);

                if (!col.Contains("") && col.Distinct().Count() == 1)
                {
                    return true;
                }
            }
            return false;
        }

        public bool IsFull()
        {
            foreach (var cell in cells)
            {
                if (string.IsNullOrEmpty(cell))
                {
                    return false;
                }
            }

            return true;
        }

        public bool IsValidPosition(int row, int col, bool fullCheck = true)
        {
            if (row < 0 || col < 0 || row > SIZE || col > SIZE)
            {
                return false;
            }
            return !fullCheck || string.IsNullOrEmpty(cells[row, col]);
        }

        public void SetCell(int row, int col, string mark)
        {
            if (!IsValidPosition(row, col))
            {
                throw new Exception("Invalid row or column value. Try again");
            }
            else
            {
                cells[row, col] = mark;
            }
        }

        public void SetRemainingCells()
        {
            for (int i = 0; i < SIZE; i++)
            {
                for (int j = 0; j < SIZE; j++)
                {
                    if (string.IsNullOrEmpty(cells[i, j]))
                    {
                        SetCell(i, j, "-");
                    }
                }
            }
        }
    }
}
