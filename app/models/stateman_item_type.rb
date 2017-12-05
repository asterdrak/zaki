# frozen_string_literal: true
class StatemanItemType < StatemanResource
  self.prefix = '/organizations/:organization_id/'
  self.element_name = 'item_type'

  belongs_to :stateman_organization
  has_many :stateman_items
end
