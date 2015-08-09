require "dirty_associations/version"
require "active_model"

module DirtyAssociations

  def changed?
    check_if_associations_changed
    super
  end

  def changed_attributes
    check_if_associations_changed
    super
  end

  def previous_changes
    check_if_associations_changed
    super
  end

  def changes
    check_if_associations_changed
    super
  end

  def attribute_change(attr)
    changed_attributes[attr].map(&:changes) if self.association(attr) && attribute_changed?(attr)
  rescue ActiveRecord::AssociationNotFoundError
    super
  end

  private

  def check_if_associations_changed
    self.class.reflect_on_all_autosave_associations.each do |reflection|
      association_id = reflection.name
      autosaving_targets = self.association(association_id).target
      autosaving_targets_that_will_change = autosaving_targets.select { |t| t.new_record? || t.changed? || t.marked_for_destruction? }
      if autosaving_targets && autosaving_targets_that_will_change.size > 0
        @changed_attributes[association_id] = autosaving_targets_that_will_change
      end
    end
  end
end
