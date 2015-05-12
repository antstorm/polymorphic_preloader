require 'spec_helper'

describe PolymorphicPreloader do
  subject { PolymorphicPreloader }

  it 'can be initialized' do
    preloader = subject.new([], :key)

    expect(preloader).to be_instance_of(PolymorphicPreloader)
  end

  it 'stores association key' do
    preloader = subject.new([], :polymorphic)

    expect(preloader.association_name).to be_eql(:polymorphic)
  end

  it 'groups objects by polymorphic association' do
    object_1 = double
    allow(object_1).to receive(:polymorphic_type) { 'First' }

    object_2 = double
    allow(object_2).to receive(:polymorphic_type) { 'Second' }

    preloader = subject.new([object_1, object_2], :polymorphic)

    expect(preloader.grouped_objects).to include('First' => [object_1])
    expect(preloader.grouped_objects).to include('Second' => [object_2])
  end
end
