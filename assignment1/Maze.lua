Maze = Class{}


function Maze:init(width, height, thickness)
    self.width = width
    self.height = height
    self.thickness = thickness
    self.maze = init_maze(width, height)
    carve_maze(self.maze, width, height, 2, 2, 0)
    self.maze[width + 2] = 0
    self.maze[(height - 2) * width + width - 3] = 0
    maze_canvas = love.graphics.newCanvas(width*thickness, height*thickness)
    love.graphics.setCanvas(maze_canvas)
    love.graphics.clear()
    love.graphics.setColor(0, 0, 0, 255)
    for i,v in ipairs(self.maze) do
        if v ~= 0 then
            x = ((i % self.width)*self.thickness)
            y = (math.floor(i / self.width)*self.thickness)
            love.graphics.rectangle('fill', x, y, self.thickness, self.thickness)
        end
    end
    love.graphics.setCanvas()
    self.image = love.graphics.newImage(maze_canvas:newImageData())
end


function init_maze(width, height)
    local result = {}
    for y = 0, height - 1 do
       for x = 0, width - 1 do
          result[y * width + x] = 1
       end
       result[y * width + 0] = 0
       result[y * width + width - 1] = 0
    end
    for x = 0, width - 1 do
       result[0 * width + x] = 0
       result[(height - 1) * width + x] = 0
    end
    return result
 end
 
 -- Carve the maze starting at x, y.
 function carve_maze(maze, width, height, x, y, double_direction)
    local r = math.random(0, 3)
    local double_direction = math.max(math.random(1, 2), double_direction)
    maze[y * width + x] = 0
    for i = 0, 3 do
       local d = (i + r) % 4
       local dx = 0
       local dy = 0
       if d == 0 then
          dx = 1
       elseif d == 1 then
          dx = -1
       elseif d == 2 then
          dy = 1
       else
          dy = -1
       end
       local nx = x + dx
       local ny = y + dy
       local nx2 = nx + dx
       local ny2 = ny + dy
       if maze[ny * width + nx] == 1 then
          if maze[ny2 * width + nx2] == 1 then
            maze[ny * width + nx] = 0
             if double_direction == 1 then
                carve_maze(maze, width, height, x, y, 2)
             end
             carve_maze(maze, width, height, nx2, ny2, 0)
          end
       end
    end
 end


function Maze:render()
    love.graphics.draw(self.image, 8, 80)
end