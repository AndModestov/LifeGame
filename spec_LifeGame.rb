require 'rspec'
require_relative 'cell.rb'
require_relative 'game.rb'
require_relative 'world.rb'

describe 'Game of Life' do

  let(:world){ World.new(200,200)}
  let(:game) { Game.new(world) }
  let(:cell) { world.cell_board[1][1] }

  describe 'World' do
    subject { world }

    it 'Responds to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_board)
      expect(subject).to respond_to(:cells)
    end

    it 'Cellboard initialize' do
      expect(subject.cell_board.is_a?(Array)).to be true
      subject.cell_board.each do |row|
        expect(row.is_a?(Array)).to be true
        row.each do |element|
          expect(element.is_a?(Cell)).to be true
          expect(element.alive).to be false
        end
      end
    end

    it 'Can count cells' do
      expect(subject.cells.count).to eq subject.rows * subject.cols
    end

    it 'Check live neighbour up' do
      subject.cell_board[cell.y - 1][cell.x].alive = true
      expect(subject.live_neighbours(cell).count).to eq 1
    end
    it 'Check live neighbour up-right' do
      subject.cell_board[cell.y - 1][cell.x + 1].alive = true
      expect(subject.live_neighbours(cell).count).to eq 1
    end
    it 'Check live neighbour right' do
      subject.cell_board[cell.y][cell.x + 1].alive = true
      expect(subject.live_neighbours(cell).count).to eq 1
    end
    it 'Check live neighbour down-right' do
      subject.cell_board[cell.y + 1][cell.x + 1].alive = true
      expect(subject.live_neighbours(cell).count).to eq 1
    end
    it 'Check live neighbour down' do
      subject.cell_board[cell.y + 1][cell.x].alive = true
      expect(subject.live_neighbours(cell).count).to eq 1
    end
    it 'Check live neighbour down-left' do
      subject.cell_board[cell.y + 1][cell.x - 1].alive = true
      expect(subject.live_neighbours(cell).count).to eq 1
    end
    it 'Check live neighbour left' do
      subject.cell_board[cell.y][cell.x - 1].alive = true
      expect(subject.live_neighbours(cell).count).to eq 1
    end
    it 'Check live neighbour left-up' do
      subject.cell_board[cell.y - 1][cell.x - 1].alive = true
      expect(subject.live_neighbours(cell).count).to eq 1
    end

    it 'Detects no live neighbours' do
      expect(subject.live_neighbours(cell)).to eq []
    end

    it 'Initial configuration of the world' do
      expect(subject.live_cells).to eq []
      subject.start_life
      expect(subject.live_cells).not_to eq []
    end

  end


  describe 'Game' do
    subject { game }

    it 'Creating new game object' do
      expect(subject.world.is_a?(World)).to be true
    end

    describe 'Rules' do

      describe 'Rule №1' do
        it 'Kills live cell without neighbours' do
          game.world.cell_board[1][1].alive = true
          expect(game.world.cell_board[1][1].alive).to be true
          game.next_step!
          expect(game.world.cell_board[1][1].alive).to be false
        end

        it 'Kills live cell with 1 neighbour' do
          game.world.cell_board[0][1].alive = true
          game.world.cell_board[1][1].alive = true
          game.next_step!
          expect(game.world.cell_board[0][1].alive).to be false
          expect(game.world.cell_board[1][1].alive).to be false
        end
      end

      describe 'Rule №2' do
        it 'Should keep alive cell with 2 neighbours' do
          game.world.cell_board[0][1].alive = true
          game.world.cell_board[1][1].alive = true
          game.world.cell_board[2][1].alive = true
          expect(world.live_neighbours(cell).count).to eq 2
          game.next_step!
          expect(world.cell_board[0][1].alive).to be false
          expect(world.cell_board[1][1].alive).to be true
          expect(world.cell_board[2][1].alive).to be false
        end

        it 'Should keep alive cell with 3 neighbours' do
          game.world.cell_board[0][1].alive = true
          game.world.cell_board[1][1].alive = true
          game.world.cell_board[2][1].alive = true
          game.world.cell_board[2][2].alive = true
          expect(world.live_neighbours(cell).count).to eq 3
          game.next_step!
          expect(world.cell_board[0][1].alive).to be false
          expect(world.cell_board[1][1].alive).to be true
          expect(world.cell_board[2][1].alive).to be true
          expect(world.cell_board[2][2].alive).to be true
        end
      end

      describe 'Rule №3' do
        it 'Should kill alive cell with more than 3 neighbours' do
          game.world.cell_board[0][1].alive = true
          game.world.cell_board[1][1].alive = true
          game.world.cell_board[2][1].alive = true
          game.world.cell_board[2][2].alive = true
          game.world.cell_board[1][2].alive = true
          expect(world.live_neighbours(cell).count).to eq 4
          game.next_step!
          expect(world.cell_board[0][1].alive).to be true
          expect(world.cell_board[1][1].alive).to be false
          expect(world.cell_board[2][1].alive).to be true
          expect(world.cell_board[2][2].alive).to be true
          expect(world.cell_board[1][2].alive).to be false
        end
      end

      describe 'Rule №4' do
        it 'Revives dead cell with 3 neighbours' do
          game.world.cell_board[0][1].alive = true
          game.world.cell_board[1][1].alive = true
          game.world.cell_board[2][1].alive = true
          expect(world.live_neighbours(world.cell_board[1][0]).count).to eq 3
          game.next_step!
          expect(world.cell_board[1][0].alive).to be true
          expect(world.cell_board[1][2].alive).to be true
        end
      end

    end
  end


  describe 'Cell' do
    subject { Cell.new }

    it 'Initialize new cell object ' do
      expect(subject.alive).to be false
    end

    it 'Respond to params' do
      expect(subject).to respond_to(:x)
      expect(subject).to respond_to(:y)
      expect(subject).to respond_to(:alive)
    end
  end

end
