namespace tic_tac_cs
{
    internal class Player
    {
        private string name;
        private string mark;

        public Player(string name, string mark)
        {
            this.name = name;
            this.mark = mark;
        }

        public string Name
        {
            get { return name; }
        }

        public string Mark
        {
            get { return mark; }
        }
    }
}
