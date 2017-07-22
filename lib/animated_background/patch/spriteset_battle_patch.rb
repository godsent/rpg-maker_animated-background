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
