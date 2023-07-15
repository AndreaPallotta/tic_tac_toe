Player := Object clone
Player name := nil
Player mark := nil

Player create := method(name, mark,
    self name = name
    self mark = mark
)