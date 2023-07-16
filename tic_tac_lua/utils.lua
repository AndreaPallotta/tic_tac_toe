local Mark = {
   O = "O",
   X = "X",
   DEF = "-"
}

local function clear_terminal()
    io.write("\027[H\027[2J")
end

local function f(str)
   local outer_env = _ENV
   return (str:gsub("%b{}", function(block)
      local code = block:match("{(.*)}")
      local exp_env = {}
      setmetatable(exp_env, { __index = function(_, k)
         local stack_level = 5
         while debug.getinfo(stack_level, "") ~= nil do
            local i = 1
            repeat
               local name, value = debug.getlocal(stack_level, i)
               if name == k then
                  return value
               end
               i = i + 1
            until name == nil
            stack_level = stack_level + 1
         end
         return rawget(outer_env, k)
      end })
      local fn, err = load("return "..code, "expression `"..code.."`", "t", exp_env)
      if fn then
         return tostring(fn())
      else
         error(err, 0)
      end
   end))
end

local function get_username(player_num)
    local def_name = f"Player {player_num}"

    io.write(f"Insert player {player_num} name (default '{def_name}'): ")
    local input = io.read()
    local trimmed_input = string.gsub(input, '^%s*(.-)%s*$', '%1')

    if trimmed_input == "" then
        return def_name
    end
    return trimmed_input
end

local function get_user_coords(player_name)
    io.write(f"Player {player_name}, enter row and column (e.g. '1 2'): ")
    local a,b = io.read("*n", "*n")

    if a == nil or b == nil then
        error("Invalid row or column. Try again")
    end
    return a,b
end

return {
    clear_terminal = clear_terminal,
    f = f,
    get_username = get_username,
    get_user_coords = get_user_coords,
    Mark = Mark,
}