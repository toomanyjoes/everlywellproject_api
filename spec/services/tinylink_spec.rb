require 'rails_helper'

describe Tinylink do
  describe '#shorten' do
    it 'should shorten the link given' do
      response = described_class.shorten("https://www.bogusurl.com")
      expect(response).to eq('http://bit.ly/2FbQ4iW')
    end
    it 'should have 200 status code' do
      response = described_class.shorten("https://www.bogusurl.com")
      expect(response).kind_of?(Net::HTTPOK)
    end
    it 'should raise an error if call to bit.ly isn\'t successful' do
      expect { described_class.shorten("https://www.error.com") }.to raise_error('there was a problem shortening the link')
    end
  end
end