# frozen_string_literal: true
class StatemanOrganization < ApplicationResource
  self.element_name = 'organization'

  has_many :stateman_item_types
  has_many :stateman_trials
end
