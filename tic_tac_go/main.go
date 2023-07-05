package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"runtime"
	"strconv"
	"strings"
)

// ============== PLAYER ==============

type Player struct {
	name  string
	mark  PlayerMark
}
type PlayerMark string
const (
	X PlayerMark = "X"
	O PlayerMark = "O"
)

func NewPlayer(name string, mark PlayerMark) *Player {
	return &Player{
		name: name,
		mark: mark,
	}
}

func (player *Player) GetName() string {
	return player.name
}

func (player *Player) GetMark() PlayerMark {
	return player.mark
}

func (player *Player) SetMark(mark PlayerMark) {
	player.mark = mark
}

func (player *Player) SetName(name string) {
	player.name = name
}

func (player *Player) MakeMove(board *Board, row, col int) bool {
	if isValid, err := board.SetCell(row, col, player.mark); isValid == false || err != nil {
		return false
	}
	return true
}

// ============== BOARD ==============

type Board struct {
	cells [3][3]string
}

func NewBoard() *Board {
	board := &Board{}
	for i := range board.cells {
        for j := range board.cells[i] {
            board.cells[i][j] = "   "
        }
    }
    return board
}

func (board *Board) Display() {
	fmt.Println("      c1  c2  c3")
	fmt.Println("    -------------")
	for i := 0; i < 3; i++ {
		fmt.Printf("r%d  |", i + 1)
        for j := 0; j < 3; j++ {
            fmt.Print(board.cells[i][j])
			fmt.Print("|")
        }
        fmt.Println()
        if i < 2 {
            fmt.Println("    -------------")
        }
    }
	fmt.Println("    -------------")
}

func (board *Board) IsValidPosition(row, col int) bool {
	if row < 0 || row > 2 || col < 0 || col > 2 {
		return false
	}
	if strings.TrimSpace(board.cells[row][col]) != "" {
		return false
	}
	return true
}

func (board *Board) SetCell(row, col int, mark PlayerMark) (bool, error) {
	if !board.IsValidPosition(row, col) {
		return false, fmt.Errorf("Invalid move. Indexes are invalid or cell is already takes")
	}
	board.cells[row][col] = " " + string(mark) + " "
	return true, nil
}

func (board *Board) GetCell(row, col int) (string, error) {
	if !board.IsValidPosition(row, col) {
		return "", fmt.Errorf("Invalid row or column index")
	}
	return board.cells[row][col], nil
}

func (b *Board) IsFull() bool {
	for _, row := range b.cells {
		for _, cell := range row {
			trimmed := strings.TrimSpace(cell)
			if trimmed == "" || trimmed == "-" {
				return false
			}
		}
	}
	return true
}

func (board *Board) IsWinner() bool {
	return board.HasHorizontalWin() || board.HasVerticalWin() || board.HasDiagonalWin()
}

func (b *Board) HasHorizontalWin() bool {
	for row := 0; row < 3; row++ {
		if allEquals(b.cells[row][:]) {
			return true
		}
	}
	return false
}

func (board *Board) HasVerticalWin() bool {
	for col := 0; col < 3; col++ {
		colArr := []string{board.cells[0][col], board.cells[1][col], board.cells[2][col]}
		if allEquals(colArr) {
			return true
		}
	}
	return false
}

func (board *Board) HasDiagonalWin() bool {
	d1 := []string{board.cells[0][0], board.cells[1][1], board.cells[2][2]}
    d2 := []string{board.cells[0][2], board.cells[1][1], board.cells[2][0]}

    return allEquals(d1) || allEquals(d2)
}

func (board *Board) SetRemaining() {
	for i, row := range board.cells {
		for j, element := range row {
			if strings.TrimSpace(element) == "" {
				board.cells[i][j] = " - "
			}
		}
	}
}

// ============== GAME ==============

type Game struct {
	board          *Board
	player1        *Player
	player2        *Player
	currentPlayer  *Player
	winner         *Player
}

func NewGame(p1, p2 *Player) *Game {
	return &Game {
		player1: p1,
		player2: p2,
		board: NewBoard(),
		currentPlayer: p1,
		winner: nil,
	}
}

func (game *Game) GetCurrentPlayer() *Player {
	if game.currentPlayer == game.player1 {
		return game.player1
	}
	return game.player2
}

func (game *Game) SwitchCurrentPlayer() {
	if game.currentPlayer == game.player1 {
		game.currentPlayer = game.player2
	} else {
		game.currentPlayer = game.player1
	}
}

func (game *Game) Display() {
	game.board.Display()
}

func (game *Game) GetPlayerMove() (int, int) {
	reader := bufio.NewReader(os.Stdin)
	for {
		fmt.Printf("Player '%s', enter row and column (e.g. '1 2'): ", game.currentPlayer.GetName())
		input, _ := reader.ReadString('\n')
		row, col, err := parseInput(input, game.board)

		if err != nil {
			fmt.Println(err.Error())
			continue;
		}
		if game.board.IsValidPosition(row, col) {
			return row, col
		} else {
			fmt.Println("Invalid row and columns. Try again")
			continue
		}
	}
}

func (game *Game) IsWinner() bool {
	return game.board.IsWinner()
}

func (game *Game) IsDraw() bool {
	return game.board.IsFull()
}

func (game *Game) IsOver() bool {
	if (game.IsDraw()) {
		game.winner = nil
		game.currentPlayer = nil
		return true
	}

	if (game.IsWinner()) {
		game.winner = game.currentPlayer
		clearTerminal()
		game.board.SetRemaining()
		game.Display()
		return true
	}

	return false
}

func (game *Game) AnnounceDraw() {
	fmt.Println("It is a draw!")
}

func (game *Game) AnnounceWinner() {
	fmt.Printf("%s is the winner!\n", game.winner.GetName())
}

// ============== UTILS ==============

func allEquals (arr []string) bool {
	if len(arr) < 1 || strings.TrimSpace(arr[0]) == "" {
		return false
	}

	element := arr[0]
	for i := 1; i < len(arr); i++ {
		if arr[i] != element {
			return false
		}
	}
	return true
}

func parseInput(input string, board *Board) (int, int, error) {
	fields := strings.Fields(input)

	if len(fields) != 2 {
		return 0, 0, fmt.Errorf("Invalid Input. Please enter row and column serated by a space.")
	}
	row, err1 := strconv.Atoi(fields[0])
	col, err2 := strconv.Atoi(fields[1])

	if err1 != nil || err2 != nil || !board.IsValidPosition(row - 1, col - 1) {
		return 0, 0, fmt.Errorf("Invalid input. Please enter valid row and column")
	}

	return row - 1, col - 1, nil
}

func parseName(reader *bufio.Reader, defName string) string {
	input, err := reader.ReadString('\n')
	trimmed := strings.TrimSpace(input)

	if err != nil || trimmed == "" {
		return defName
	} else {
		return trimmed
	}
}

func getPlayerNames() (string, string) {
	reader := bufio.NewReader(os.Stdin)

	fmt.Print("Insert Player 1 name (default 'Player 1'): ")
	p1Name := parseName(reader, "Player 1")

	fmt.Print("Insert Player 1 name (default 'Player 2'): ")
	p2Name := parseName(reader, "Player 2")

	return p1Name, p2Name
}

func runCmd(name string, args ...string) {
    cmd := exec.Command(name, args...)
    cmd.Stdout = os.Stdout
    cmd.Run()
}

func clearTerminal() {
	switch runtime.GOOS {
	case "darwin", "linux":
		runCmd("clear")
	case "windows":
		runCmd("cmd", "/c", "cls")
	default:
		runCmd("clear")
	}
}

// ============== MAIN ==============

func main() {
	clearTerminal()
	fmt.Println("Welcome to Tic Tac Go!")
	fmt.Println()

	p1Name, p2Name := getPlayerNames()

	p1 := Player{ name: p1Name, mark: X}
	p2 := Player{ name: p2Name, mark: O}

	game := NewGame(&p1, &p2)
	game.Display()

	for !game.IsOver() {
		current := game.GetCurrentPlayer()
		row, col := game.GetPlayerMove()

		isValid := current.MakeMove(game.board, row, col)

		if !isValid {
			fmt.Println("Invalid Move. Try Again")
			continue
		}

		clearTerminal()
		fmt.Println("Here's the updated board:")
		fmt.Println()
		game.Display()

		if game.IsOver() {
			break
		}

		game.SwitchCurrentPlayer()
		fmt.Printf("\nIt is now %s turn!\n", game.currentPlayer.GetName())
	}

	fmt.Println("Game over!")

	if game.IsDraw() {
		game.AnnounceDraw()
	} else {
		game.AnnounceWinner()
	}
}
