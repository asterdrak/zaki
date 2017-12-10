# frozen_string_literal: true
class StatemanOrganization < StatemanResource
  self.element_name = 'organization'

  has_many :stateman_item_types
  has_many :stateman_trials
  has_many :stateman_states
end
