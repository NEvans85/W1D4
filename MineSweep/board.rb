require_relative 'tile'

class Board
  def initialize(grid)
    @grid = grid
  end

  def self.random_board(num_bombs)
    rand_board = Board.new(easy_grid)
    bomb_pos = random_positions(num_bombs)
    bomb_pos.each do |pos|
      rand_board.place_bomb(pos)
    end
    rand_board
  end

  def self.easy_grid
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
      temp_pos = [rand(@grid.length), rand(@grid.length)]
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
        print "#{render_tile_at([r_idx, c_idx])}|"
      end
      print "\n"
    end
  end

  def render_tile_at(pos)
    if self[pos].revealed?
      if self[pos].bomb?
        'B'
      elsif neightbors(pos).any? { |n_pos| self[n_pos].bomb? }
        bomb_count(neighbors(pos)).to_s
      else
        '_'
      end
    elsif self[pos].flagged?
      'F'
    else
      '*'
    end
  end

  def bomb_count(arr_of_pos)
    arr_of_pos.count { |pos| self[pos].bomb? }
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
