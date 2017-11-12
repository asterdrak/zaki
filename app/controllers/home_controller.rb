# frozen_string_literal: true
class HomeController < ApplicationController
  skip_before_action :login_required, only: :index

  def index; end

  def private_index; end
end
