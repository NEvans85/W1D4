require_relative 'tile'

class Board
  def initialize(grid)
    @grid = grid
  end

  def self.random_board(num_bombs)
    grid = Array.new(9) { Array.new(9) { Tile.new } }
    rand_board = Board.new(grid)
    bomb_pos = rand_board.random_positions(num_bombs)
    bomb_pos.each do |pos|
      rand_board.place_bomb(pos)
    end
    rand_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, tile)
    row, col = pos
    @grid[row][col] = tile
  end

  def random_positions(amt)
    bomb_pos = []
    while amt > 0
      temp_pos = [rand(9), rand(9)]
      unless bomb_pos.include?(temp_pos)
        bomb_pos << temp_pos
        amt -= 1
      end
    end
    bomb_pos
  end

  def place_bomb(pos)
    self[pos].set_bomb
  end

  def render
    @grid.map do |row|
      row.map do |tile|
        # TODO: display tile state
      end
    end
  end

  def neighbors(pos)
    result = []
    row, col = pos
    (-1..1).each do |int|
      result << 
    end
  end

  def valid_pos?(pos)
    pos.all? { |coord| (0..8).cover?(coord) }
  end

end
