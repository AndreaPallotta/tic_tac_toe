namespace tic_tac_cs
{
    internal class Utils
    {
        public static void ClearTerminal()
        {
            Console.Write("\x1B[2J\x1B[H");
        }

        public static string GetUserName(int playerNum)
        {
            string defName = $"Player {playerNum}";
            Console.Write($"Insert Player {playerNum} name (default '{defName}'): ");
            string input = Console.ReadLine() ?? string.Empty;
            string trimmedInput = input.Trim();

            if (string.IsNullOrEmpty(trimmedInput))
            {
                return defName;
            }

            return trimmedInput;
        }

        public static string[] GetUserInput(string playerName)
        {
            Console.Write($"Player {playerName}, enter row and column (e.g. '1 2'): ");
            string input = Console.ReadLine() ?? string.Empty;

            return input.Trim().Split(' ');
        }

        public static Tuple<int, int> InputToCoords(string[] input)
        {
            if (input.Length != 2)
            {
                throw new Exception("Invalid row or column. Try again");
            }

            try
            {
                int row = int.Parse(input[0]);
                int col = int.Parse(input[1]);

                return new Tuple<int, int>(row - 1, col - 1);
            }
            catch (Exception)
            {
                throw new Exception("Invalid row or column. Try again");
            }
        }

        public static string[] GetRow(string[,] matrix, int rowNum)
        {
            return Enumerable.Range(0, matrix.GetLength(1)).Select(x => matrix[rowNum, x]).ToArray();
        }

        public static string[] GetColumn(string[,] matrix, int colNum)
        {
            matrix.GetLength(0);
            return Enumerable.Range(0, matrix.GetLength(0)).Select(x => matrix[x, colNum]).ToArray();
        }
    }
}
