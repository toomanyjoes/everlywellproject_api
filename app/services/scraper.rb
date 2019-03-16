require 'nokogiri'
require 'open-uri'

class Scraper
  def self.scrape_url(url)
    doc = Nokogiri::HTML(open(url))
    [
        *doc.search('h1', 'h2', 'h3').map { |h|
          [
              h.content.downcase!
          ]
        }.flatten
    ]
  end
end