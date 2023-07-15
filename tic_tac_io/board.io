repeat := method(value, count,
    result := List clone
    for(i, 0, count, 1,
        result append(value)
    )
    return result
)

transpose := method(array,
    transposed := List clone
    arrSize := array size

    for(i, 0, array size - 1,
        column := List clone

        for(j, 0, array at(0) size - 1,
            column append(array at(j) at(i))
        )
        transposed append(column)
    )
)

Board := Object clone
Board size := 3
Board cells := List clone


for(i, 0, Board size - 1,
    row := List clone
    for(j, 0, Board size - 1,
        row append("")
    )
    Board cells append(row)
)

Board isValidPosition := method(row, col, fullCheck,
    if(row < 0 or col < 0 or row >= Board size or col >= Board size,
        return false
    )

    if(fullCheck,
        return cells at(row) at(col) isEmpty
    )

    return true
)

Board getCell := method(row, col,
    if(isValidPosition(row, col, false) == false,
        Exception raise("Invalid row or column value. Try again")
    )

    return cells at(row) at(col)
)

Board setCell := method(row, col, mark,
    if(isValidPosition(row, col, true) == false,
        Exception raise("Invalid row or column value. Try again")
    )

    cells at(row) atPut(col, mark)
)

Board display := method(
    writeln("\n     c1  c2  c3")
    writeln("    ------------")

    for(i, 0, Board size - 1,
        write("r" .. (i + 1) asString .. " |")
        for(j, 0, Board size - 1,
            cell := cells at(i) at(j)
            if (cell == "") then (
                write("  " .. (cell asString) .. " |")
            ) else (
                write(" " .. (cell asString) .. " |")
            )
        )
        writeln("\n   -------------")
    )
    writeln("")
)

Board isFull := method(
    for(i, 0, Board size - 1,
        for(j, 0, Board size - 1,
            if (cells at(i) at(j) == "",
                return false
            )
        )
    )

    return true
    // return cells every(row, row any(cell, cell isEmpty))
)

Board hasHorizontalWin := method(
    for(i, 0, Board size - 1,
        if(cells at(i) unique size == 1 and cells at(i) first != "",
            return true
        )
    )
    return false
)

Board hasVerticalWin := method(
    transposed := transpose(cells)
    for(i, 0, transposed size - 1,
        if(transposed at(i) unique size == 1 and transposed at(i) first != "",
            return true
        )
    )
    return false
)

Board hasDiagonalWin := method(
    mainDiag := List clone
    secDiag := List clone

    for(i, 0, Board size - 1,
        mainDiag append(cells at(i) at(i))
        secDiag append(cells at(i) at(Board size - i - 1))
    )

    mainMatch := mainDiag unique size == 1 and mainDiag first != ""
    secMatch := secDiag unique size == 1 and secDiag first != ""

    return mainMatch or secMatch
)

Board checkWinner := method(
    return hasHorizontalWin() or hasVerticalWin() or hasDiagonalWin()
)

Board setRemainingCells := method(
    for(i, 0, Board size - 1,
        for(j, 0, Board size - 1,
            if(cells at(i) at(j) isEmpty,
                setCell(i, j, "-")
            )
        )
    )
)