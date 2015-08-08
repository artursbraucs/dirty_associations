require "dirty_associations/version"
require "active_support"

module DirtyAssociations
  extend ActiveSupport::Concern

  included do
    before_validation :check_if_associations_changed
  end

  private

  def check_if_associations_changed
    will_change = false
    self.class.reflect_on_all_autosave_associations.each do |reflection|
      reflection_name = reflection.name
      if self.association(reflection_name).loaded?
        if reflection.collection?
          will_change = self.send(reflection_name).any? { |record| associated_record_changed?(record) }
        else
          will_change = associated_record_changed?(self.send(reflection_name))
        end
      end
      attribute_will_change!(reflection_name) if will_change
    end
  end

  def associated_record_changed?(record)
    record.class.send(:include, ActiveModel::DirtyAssociations) unless record.respond_to?(:check_if_associations_changed)
    return record.send(:check_if_associations_changed) && record.changed?
  end
end
