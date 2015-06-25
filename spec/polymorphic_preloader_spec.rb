require 'spec_helper'

describe PolymorphicPreloader do
  subject { PolymorphicPreloader }

  it 'can be initialized' do
    preloader = subject.new([], :key)

    expect(preloader).to be_instance_of(PolymorphicPreloader)
  end

  it 'stores a local reference to ActiveRecord preloader' do
    preloader = subject.new([], :key)

    expect(preloader.send(:preloader)).to be_instance_of(ActiveRecord::Associations::Preloader)
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

  it 'preloads association' do
    object = double
    allow(object).to receive(:polymorphic_type) { 'Object' }

    preloader = subject.new([object], :polymorphic)

    expect(preloader.send(:preloader)).to receive(:preload).with([object], polymorphic: :association)

    preloader.preload!(object: :association)
  end

  it 'preloads multiple associations' do
    object_1 = double
    allow(object_1).to receive(:polymorphic_type) { 'FirstObject' }

    object_2 = double
    allow(object_2).to receive(:polymorphic_type) { 'SecondObject' }

    preloader = subject.new([object_1, object_2], :polymorphic)

    expect(preloader.send(:preloader)).to receive(:preload).with([object_1], polymorphic: :association_1)
    expect(preloader.send(:preloader)).to receive(:preload).with([object_2], polymorphic: :association_2)

    preloader.preload!(first_object: :association_1, second_object: :association_2)
  end

  it 'does not preload not specified associations' do
    object = double
    allow(object).to receive(:polymorphic_type) { 'Object' }

    preloader = subject.new([object], :polymorphic)

    expect(preloader.send(:preloader)).not_to receive(:preload)

    preloader.preload!(another_object: :association)
  end
end
