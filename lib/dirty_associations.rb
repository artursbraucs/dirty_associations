require 'dirty_associations/version'
require 'dirty_associations/changed_associations'
require 'dirty_associations/changes_marker'

# Tracks nested association changes in ActiveRecord objects.
# Marks all changes in parent if something in child (one to one, one to many)
# records has changed.
module DirtyAssociations
  include ChangesMarker
end
