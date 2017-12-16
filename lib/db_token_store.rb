# frozen_string_literal: true
# Implementation of user token storage backed by a commmitee field
class DbTokenStore < Google::Auth::TokenStore
  def initialize(store)
    @store = store
  end

  # (see Google::Auth::Stores::TokenStore#load)
  def load(id)
    @store.find(id).drive_token
  end

  # (see Google::Auth::Stores::TokenStore#store)
  def store(id, token)
    @store.find(id).update(drive_token: token)
  end

  # (see Google::Auth::Stores::TokenStore#delete)
  def delete(id)
    @store.find(id).update(drive_token: nil)
  end
end
