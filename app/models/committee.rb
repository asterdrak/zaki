# frozen_string_literal: true
class Committee < ApplicationRecord
  # t.string   "name",                     null: false
  # t.datetime "created_at",               null: false
  # t.datetime "updated_at",               null: false
  # t.string   "formsub_committee_id"
  # t.integer  "overdue_state_id"
  # t.integer  "positive_finish_state_id"
  # t.integer  "negative_finish_state_id"
  # t.index ["name"], name: "index_committees_on_name", unique: true, using: :btree

  # validations
  validates :name, presence: true, uniqueness: true
  # validates :stateman, presence: true

  # relations
  has_many :trials, dependent: :restrict_with_exception
  has_one :stateman, dependent: :destroy
  has_many :ranks, dependent: :restrict_with_exception
  has_many :environments, dependent: :restrict_with_exception

  # callbacks
  after_create :create_stateman_resources
  after_save :create_formsub_resource, unless: :formsub_committee_id?

  # rest instance methods
  def formsub_committee
    FormsubCommittee.find(formsub_committee_id)
  end

  def finish_state_ids
    [positive_finish_state_id, negative_finish_state_id]
  end

  private

  def create_stateman_resources
    organization = StatemanOrganization.create(name: name)
    create_stateman(organization_id: organization.id) if organization.save

    return if stateman.trials_created?

    stateman.update(trials_created: StatemanItemType.create(
      title: 'trials', organization_id: organization.id
    ))
  end

  def create_formsub_resource
    committee = FormsubCommittee.create(name: name, zaki_committee_id: id)
    update(formsub_committee_id: committee.id) if committee.save
  end

  def stateman_present?
    stateman.present?
  end
end
