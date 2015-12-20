require_relative 'cell.rb'
require_relative 'game.rb'
require_relative 'world.rb'
require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    @height = 800
    @width = 800
    @alive_color = Gosu::Color.new(0xff777ccc)
    @dead_color = Gosu::Color.new(0xff333999)

    super @height, @width
    self.caption = "Life Game"

    @rows = @height/5
    @cols = @width/5
    @cell_height = @height/@rows
    @cell_width = @width/@cols

    @world = World.new(@cols, @rows)
    @game = Game.new(@world)

    @game.world.start_life
    @step = 0
  end

  def update
    @game.next_step!
    @step += 1
    puts "Step № #{@step}"
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

window = GameWindow.new
window.show

