# frozen_string_literal: true
class StatemanState < ApplicationResource
  self.prefix = '/organizations/:organization_id/:item_type/'
  self.element_name = 'state'

  belongs_to :stateman_trial
end
