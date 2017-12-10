# frozen_string_literal: true
class StatemanState < StatemanResource
  self.prefix = '/organizations/:organization_id/trials/'
  self.element_name = 'state'

  belongs_to :stateman_trial
  belongs_to :stateman_organization
end
