# frozen_string_literal: true
class StatemanTrial < StatemanResource
  self.prefix = '/organizations/:organization_id/'
  self.element_name = 'trial'

  belongs_to :stateman_organization
  belongs_to :stateman_item_type
  belongs_to :stateman_state

  has_many :reachable_states, class_name: 'StatemanState'
end
