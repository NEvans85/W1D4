require_relative 'tile'

class Board
  def initialize(grid)
    @grid = grid
  end

  def self.random_board(num_bombs)
    rand_board = Board.new(empty_grid)
    bomb_pos = random_positions(num_bombs)
    bomb_pos.each do |pos|
      rand_board.place_bomb(pos)
    end
    rand_board
  end

  def self.empty_grid
    Array.new(9) { Array.new(9) { Tile.new } }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, tile)
    row, col = pos
    @grid[row][col] = tile
  end

  def self.random_positions(amt)
    random_positions = []
    while amt > 0
      temp_pos = [rand(9), rand(9)]
      unless random_positions.include?(temp_pos)
        random_positions << temp_pos
        amt -= 1
      end
    end
    random_positions
  end

  def place_bomb(pos)
    self[pos].set_bomb
  end

  def render_board
    @grid.each_with_index do |row, r_idx|
      print "#{r_idx} |"
      row.each_index do |c_idx|
        render_tile([r_idx, c_idx])
      end
    end
  end

  def render_tile(pos)
    
  end

  def neighbors(pos)
    row, col = pos
    result = [[row - 1, col - 1], [row - 1, col], [row - 1, col + 1],
              [row, col - 1],                     [row, col + 1],
              [row + 1, col - 1], [row + 1, col], [row + 1, col + 1]]
    result.select { |n_pos| valid_pos?(n_pos) }
  end

  def valid_pos?(pos)
    pos.all? { |coord| (0..8).cover?(coord) }
  end

end
