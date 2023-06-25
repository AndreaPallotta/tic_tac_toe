import java.io.BufferedReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Utils {
    public static boolean allEquals(String[] arr) {
        // return Arrays.stream(arr).distinct().count() == 1;
        boolean allSame = Arrays.stream(arr)
                            .map(String::trim)
                            .distinct()
                            .count() == 1;

        return allSame && !arr[0].trim().isEmpty();
    }

    public static String[] getMatrixCol(String[][] matrix, int col, int defValue) {
        return Stream.of(matrix)
            .map(row -> col < row.length ? row[col] : defValue)
            .toArray(String[]::new);
    }

    public static String[][] getMatrixDiags(String[][] matrix) {
        String[][] diagonals = new String[2][matrix.length];

        diagonals[0] = IntStream.range(0, matrix.length)
            .mapToObj(i -> matrix[i][i])
            .toArray(String[]::new);

        diagonals[1] = IntStream.range(0, matrix.length)
            .mapToObj(i -> matrix[i][matrix.length - i - 1])
            .toArray(String[]::new);

        return diagonals;
    }

    public static void clearTerminal() {
        System.out.print("\033\143");
    }

    public static int[] parseInput(String input, Board board) {
        String[] fields = input.trim().split(" ");

        if (fields.length != 2) {
            throw new NumberFormatException("Invalid Input. Please enter row and column separated by a space.");
        }

        int row, col;

        try {
            row = Integer.parseInt(fields[0]);
            col = Integer.parseInt(fields[1]);
        } catch (NumberFormatException nfe) {
            throw new NumberFormatException("Invalid input. Please enter valid row and column.");
        }

        if (!board.isValidPosition(row - 1, col - 1)) {
            throw new NumberFormatException("Invalid input. Please enter valid row and column.");
        }

        return new int[]{ row - 1, col - 1 };
    }

    public static String getPlayerName(BufferedReader reader, String defaultName, int playerNumber) throws IOException {
        System.out.print("Insert Player" + playerNumber + " name (default '" + defaultName + "'): ");
        String input = reader.readLine().trim();

        return input.isEmpty() ? defaultName : input;
    }
}
