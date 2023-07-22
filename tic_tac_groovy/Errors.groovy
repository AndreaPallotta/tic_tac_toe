final class Errors {

    public static final String ERR_INV_ROW_COL = 'Invalid row or column. Try again.'
    public static final String ERR_NO_CURR_PLAYER = 'Current player not found. Aborting game...'
    static String ERR_GENERIC(String error) {
        return "An error has been found: ${error}."
    }

}
