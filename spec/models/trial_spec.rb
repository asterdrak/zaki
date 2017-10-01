# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Trial, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:committee) }

  # it { is_expected.to validate_uniqueness_of(:title) }
end
