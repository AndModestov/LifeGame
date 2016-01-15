class World
  attr_accessor :rows, :cols, :cell_board, :cells
  
  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @cells = []

    @cell_board = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(col, row)
      end
    end

    @cell_board.each do |row|
      row.each do |element|
        @cells << element
      end
    end

  end

  def live_neighbours(cell)

    alive_neighbours = []

    #up
    if cell.y > 0
      candidate = self.cell_board[cell.y - 1][cell.x]
      alive_neighbours << candidate if candidate.alive?
    end

    #right
    if cell.x < (cols - 1)
      candidate = self.cell_board[cell.y][cell.x + 1]
      alive_neighbours << candidate if candidate.alive?
    end

    #down
    if cell.y < (rows - 1)
      candidate = self.cell_board[cell.y + 1][cell.x]
      alive_neighbours << candidate if candidate.alive?
    end

    #left
    if cell.x > 0
      candidate = self.cell_board[cell.y][cell.x - 1]
      alive_neighbours << candidate if candidate.alive?
    end

    #up-right
    if cell.y > 0 and cell.x < (cols - 1)
      candidate = self.cell_board[cell.y - 1][cell.x + 1]
      alive_neighbours << candidate if candidate.alive?
    end

    #down-right
    if cell.y < (rows - 1) and cell.x < (cols - 1)
      candidate = self.cell_board[cell.y + 1][cell.x + 1]
      alive_neighbours << candidate if candidate.alive?
    end

    #down-left
    if cell.y < (rows - 1) and cell.x > 0
      candidate = self.cell_board[cell.y + 1][cell.x - 1]
      alive_neighbours << candidate if candidate.alive?
    end

    #up-left
    if cell.y > 0 and cell.x > 0
      candidate = self.cell_board[cell.y - 1][cell.x - 1]
      alive_neighbours << candidate if candidate.alive?
    end

    alive_neighbours
  end

  def start_life
    #reading the start text file
    alive_coordinates = File.readlines('start.txt').map{|line| line.chomp.split(/,/)}
    #coordinates to massive element num
    alive_coordinates.map!{|i| i = i[1].to_i * @cols + i[0].to_i}
    alive_coordinates.each do |coord|
      cells[coord].alive = true
    end
  end

  def live_cells
    cells.select { |cell| cell.alive }
  end

end

