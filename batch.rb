#lib/animated_background.rb
module AnimatedBackground
  VERSION = '1.0'
  FILENAME_FLAG = 'animated'.freeze
end

#gems/../lib/animated_background/sprite.rb
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
#gems/../lib/animated_background/patch.rb
module AnimatedBackground::Patch
end

#gems/../lib/animated_background/patch/spriteset_battle_patch.rb
class Spriteset_Battle

  alias original_create_battleback1_for_animated_battleback create_battleback1
  def create_battleback1
    if battleback1_name && battleback1_name.start_with?(AnimatedBackground::FILENAME_FLAG)
      @back1_sprite = AnimatedBackground::Sprite.new(@viewport1, battleback1_name)
      @back1_sprite.bitmap = battleback1_bitmap
      @back1_sprite.z = 0
    else
      original_create_battleback1_for_animated_battleback
    end
  end

  alias original_create_battleback2_for_animated_battleback create_battleback2
  def create_battleback2
    if battleback2_name && battleback2_name.start_with?(AnimatedBackground::FILENAME_FLAG)
      @back2_sprite = AnimatedBackground::Sprite.new(@viewport1, battleback2_name)
      @back2_sprite.bitmap = battleback2_bitmap
      @back2_sprite.z = 1
    else
      original_create_battleback2_for_animated_battleback
    end
  end
end
#gems/../lib/animated_background/patch/scene_title_patch.rb
class Scene_Title

  alias original_create_background_for_animated_background create_background
  def create_background
    original_create_background_for_animated_background

    if $data_system.title1_name.start_with?(AnimatedBackground::FILENAME_FLAG)
      file_name, bitmap = $data_system.title1_name, Cache.title1($data_system.title1_name)
      @sprite1_animated = true
      @sprite1 = create_animated_back_sprite(file_name, bitmap)
    end

    if $data_system.title2_name.start_with?(AnimatedBackground::FILENAME_FLAG)
      file_name, bitmap = $data_system.title2_name, Cache.title1($data_system.title2_name)
      @sprite2_animated = true
      @sprite2 = create_animated_back_sprite(file_name, bitmap)
    end
  end

  alias original_update_for_animated_background update 

  def update
    original_update_for_animated_background

    @sprite1.update if @sprite1_animated
    @sprite2.update if @sprite2_animated
  end


  private

  def create_animated_back_sprite(file_name, bitmap)
    sprite = AnimatedBackground::Sprite.new(nil, file_name)
    sprite.bitmap = bitmap
    sprite.z = 0
    sprite
  end
end