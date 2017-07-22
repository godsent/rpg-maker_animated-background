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