require 'gosu'
require_relative 'cell.rb'
require_relative 'game.rb'
require_relative 'world.rb'

class GameWindow < Gosu::Window

  def initialize(height, width, acolor, dcolor, cell_height, cell_width, game)
    @height = height
    @width = width
    @alive_color = acolor
    @dead_color = dcolor
    @cell_height = cell_height
    @cell_width = cell_width
    @game = game

    super @height, @width
    self.caption = "Life Game"
  end

  def draw
    @game.world.cells.each do |cell|
      if cell.alive?
        draw_quad(cell.x * @cell_width, cell.y * @cell_height, @alive_color,
                  cell.x * @cell_width + @cell_width, cell.y * @cell_height, @alive_color,
                  cell.x * @cell_width + @cell_width, cell.y * @cell_height + @cell_height, @alive_color,
                  cell.x * @cell_width, cell.y * @cell_height + @cell_height, @alive_color)
      else
        draw_quad(cell.x * @cell_width, cell.y * @cell_height, @dead_color,
                  cell.x * @cell_width + @cell_width, cell.y * @cell_height, @dead_color,
                  cell.x * @cell_width + @cell_width, cell.y * @cell_height + @cell_height, @dead_color,
                  cell.x * @cell_width, cell.y * @cell_height + @cell_height, @dead_color)
      end
    end
  end

end


