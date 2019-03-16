require 'rails_helper'

describe Scraper do
  describe '#scrape_url' do
    it 'should gather all the header tags' do
      headings = described_class.scrape_url("https://www.bogusurl.com")
      expect(headings).to include("heading 1", "heading 2", "heading 3")
    end
    it 'should return empty if there are no header tags' do
      headings = described_class.scrape_url("https://www.noheaders.com")
      expect(headings).to eq([])
    end
  end
end