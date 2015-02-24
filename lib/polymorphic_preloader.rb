require 'polymorphic_preloader/version'

class PolymorphicPreloader
  attr_accessor :grouped_objects, :association_name

  def initialize(objects, association_name)
    self.association_name = association_name
    self.grouped_objects = objects.group_by { |object| object.send("#{association_name}_type") }
  end

  def preload!(associations)
    grouped_objects.each_pair do |object_type, objects_with_same_association|
      target_associations = associations[object_type.to_s.underscore.to_sym]

      if target_associations.present?
        preloader.preload objects_with_same_association, association_name => target_associations
      end
    end
  end

  def preloader
    @preloader ||= ActiveRecord::Associations::Preloader.new
  end
end
