
require_relative 'cell.rb'
require_relative 'game.rb'
require_relative 'world.rb'
require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    @height = 250
    @width = 250
    @cell_height = 5
    @cell_width = 5
    @rows_num = @height/@cell_height
    @cols_num = @width/@cell_width
    @alive_color = Gosu::Color.new(0xff777ccc)
    @dead_color = Gosu::Color.new(0xff333999)
    @start_file = 'start2.txt'

    super @height, @width
    self.caption = "Life Game"

    @world = World.new(@cols_num, @rows_num)
    @game = Game.new(@world)

    start_life

    @step = 0
  end

  def update
    @game.next_step!
    @step += 1
    puts "Step № #{@step}"
  end

#  def start_life
#    #reading the start text file
#    alive_coordinates = File.readlines(@start_file).map{|line| line.chomp.split(/,/)}
#    #coordinates to massive element num
#    alive_coordinates.map!{|i| i = i[1].to_i * @cols_num + i[0].to_i}
#    alive_coordinates.each do |coord|
#      @game.world.cells[coord].alive = true
#    end
#  end

  def start_life
    alivecells = []
    alive_coordinates = File.readlines(@start_file).map{|line| line.chomp.split(//)}
    alive_coordinates.each_index do |row|
      alive_coordinates[row].each_index do |col|
        alivecells << [col+1, row+1] if alive_coordinates[row][col] == "1"
      end  
    end
    alivecells.map!{|i| i = i[1].to_i * @cols_num + i[0].to_i}
    alivecells.each do |coord|
      @game.world.cells[coord].alive = true
    end
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

