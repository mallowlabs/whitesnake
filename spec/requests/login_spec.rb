require 'spec_helper'

describe '/login' do
  it 'redirects to /auth/github' do
    get '/login'
    expect(response).to redirect_to '/auth/github'
  end
end
