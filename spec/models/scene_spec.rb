require 'rails_helper'

RSpec.describe Scene, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  TEST_OPTION = 'frames'

  def get_scene
    Scene.new(renderer_id: 'Blender')
  end

  it 'has options acting as attributes' do
    scene = get_scene
    expect{ scene.option_test }.to raise_error(Fitrender::NotFoundError)
    scene.option_test = 'test'
    expect(scene.option_test).to eq('test')
  end

  it 'presents unset options with the default value' do
    puts 'Testing default value'

    scene = get_scene
    default_value = Renderer.find('Blender').generator.option_get(TEST_OPTION).default

    expect(scene.option_frames).to eq(default_value)
  end

  it 'allows the default value to be overriden' do
    scene = get_scene

    scene.option_frames = '1,4,5'
    expect(scene.option_frames).to eq('1,4,5')
  end
end
