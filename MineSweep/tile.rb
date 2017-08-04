class Tile

  def initialize
    @bomb = false
    @flag = false
    @revealed = false
  end

  def bomb?
    @bomb
  end

  def flag?
    @flag
  end

  def revealed?
    @revealed
  end

  def reveal
    @revealed = true
  end

  def toggle_flag
    if @flag
      @flag = false
    else
      @flag = true
    end
  end

  def set_bomb
    @bomb = true
  end

end
