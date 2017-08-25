# frozen_string_literal: true
class HomeController < ApplicationController
  before_action :login_required, except: :index

  def index; end

  def private_index; end
end
