# frozen_string_literal: true
class User < ApplicationRecord
  def decorate(hash)
    hash.each do |k, v|
      self.class.send(:attr_accessor, k)
      send("#{k}=", v)
    end
    self
  end

  def admin?
    try(:is_admin) || false
  end
end
