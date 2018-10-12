# frozen_string_literal: true
module UserPermissionConcern
  def permitted_committee_ids
    return [] if user.blank? || user.permissions.blank?
    user.permissions['zaki']['committee'].map(&:to_i)
  end
end
