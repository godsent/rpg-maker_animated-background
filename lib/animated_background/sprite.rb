class AnimatedBackground::Sprite < Sprite_Base
  def initialize(viewport, name)
    super viewport
    name =~ /\A.*_(\d+)_(\d+)\z/
    @rows = ($1 || 3).to_i
    @speed = ($2 || 10).to_i
    @updated = 0
  end

  def bitmap=(*)
    super
    @frame_height = height / @rows
    set_frame
  end


  def update
    super
    set_frame
    @updated += 1
  end

  def set_frame
    unless @prev_index == current_index
      @prev_index = current_index
      src_rect.set 0, current_index * @frame_height, width, @frame_height
    end
  end

  private

  def current_index
    @updated / @speed % @rows
  end
end
