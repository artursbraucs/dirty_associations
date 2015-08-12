require 'dirty_nested_attributes/version'
require 'dirty_nested_attributes/changed_associations'
require 'dirty_nested_attributes/changes_marker'

# Tracks nested association changes in ActiveRecord objects.
# Marks all changes in parent if something in child (one to one, one to many)
# records has changed.
module DirtyNestedAttributes
  include ChangesMarker
end
