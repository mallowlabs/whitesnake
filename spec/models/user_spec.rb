require 'spec_helper'

describe User do
  describe '.from_omniauth' do
  end

  describe '.create_from_omniauth' do
    it 'creates a new user from the OmniAuth information'
  end

  describe '#each_repository' do
    context 'without a block' do
      it 'returns an Enumerable'
    end

    context 'with a block' do
      it 'iterates each repository of the user'
    end
  end
end
