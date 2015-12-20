class Game
 attr_accessor :world

  def initialize(world)
    @world = world
  end
  
  def next_step!
    next_step_live_cells = []
    next_step_dead_cells = []

    @world.cells.each do |cell|
      neighbour_count = self.world.live_neighbours(cell).count
      #1
      if cell.alive? && neighbour_count < 2
        next_step_dead_cells << cell
      end

      #2
      if cell.alive? && neighbour_count > 3
        next_step_dead_cells << cell
      end

      #3
      if cell.alive? && (neighbour_count == 2 || neighbour_count == 3)
        next_step_live_cells << cell
      end

      #4
      if cell.dead? && neighbour_count == 3
        next_step_live_cells << cell
      end
    end

    next_step_live_cells.each do |cell|
      cell.rise!
    end
    next_step_dead_cells.each do |cell|
      cell.die!
    end
  end
end
