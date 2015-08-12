module DirtyNestedAttributes
  # :nodoc
  module ChangedAssociations
    def attribute_change(attr)
      changed_association = association(attr)
      if changed_association && attribute_changed?(attr)
        if changed_association.reflection.collection?
          changed_attributes[attr].map(&:changes)
        else
          changed_attributes[attr].changes
        end
      end
    rescue ActiveRecord::AssociationNotFoundError
      super
    end
  end
end
