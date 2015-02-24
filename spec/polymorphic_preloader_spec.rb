require 'spec_helper'

describe PolymorphicPreloader do
  it 'can be initialized' do
    preloader = PolymorphicPreloader.new([], :key)

    expect(preloader).to be_instance_of(PolymorphicPreloader)
  end
end
