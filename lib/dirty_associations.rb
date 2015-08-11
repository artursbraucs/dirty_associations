require "dirty_associations/version"
require "dirty_associations/changed_associations"
require "dirty_associations/changes_marker"

module DirtyAssociations
  include ChangesMarker
end
