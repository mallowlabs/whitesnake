require 'spec_helper'

describe 'Settings' do
  let(:github_site) { nil }

  before do
    Settings.github.stub(:site).and_return(github_site) if github_site
  end

  describe '.github_web_endpoint' do
    subject { Settings.github_web_endpoint }

    context 'when github.site is "https://api.github.com/"' do
      let(:github_site) { 'https://api.github.com/' }

      it { should eq('https://github.com/') }
    end

    context 'when github.site is "https://github.example.com:54321/"' do
      let(:github_site) { 'https://github.example.com:54321/' }

      it { should eq('https://github.example.com:54321/') }
    end
  end

  describe '.github_api_endpoint' do
    subject { Settings.github_api_endpoint }

    context 'when github.site is "https://api.github.com/"' do
      let(:github_site) { 'https://api.github.com/' }

      it { should eq('https://api.github.com/') }
    end

    context 'when github.site is "https://github.example.com:54321/"' do
      let(:github_site) { 'https://github.example.com:54321/' }

      it { should eq('https://github.example.com:54321/') }
    end
  end

  describe '.github_authorize_url' do
    subject { Settings.github_authorize_url }

    context 'when github.site is "https://api.github.com/"' do
      let(:github_site) { 'https://api.github.com/' }

      it { should eq('https://github.com/login/oauth/authorize') }
    end

    context 'when github.site is "https://github.example.com:54321/"' do
      let(:github_site) { 'https://github.example.com:54321/' }

      it { should eq('https://github.example.com:54321/login/oauth/authorize') }
    end
  end

  describe '.github_token_url' do
    subject { Settings.github_token_url }

    context 'when github.site is "https://api.github.com/"' do
      let(:github_site) { 'https://api.github.com/' }

      it { should eq('https://github.com/login/oauth/access_token') }
    end

    context 'when github.site is "https://github.example.com:54321/"' do
      let(:github_site) { 'https://github.example.com:54321/' }

      it { should eq('https://github.example.com:54321/login/oauth/access_token') }
    end
  end
end
