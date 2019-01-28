require 'HTTParty'
require 'Nokogiri'

class Scraper
  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get('http://m.cnn.com/en')
    @parse_page = Nokogiri::HTML(doc)
  end

  def get_titles
    titles = parse_page.css('li').css('a').children.map { |title| title.text}.compact
  end

  def get_links
    links = parse_page.css('li').css('a').map { |link| link['href']}.compact
  end

  scraper = Scraper.new
  titles = scraper.get_titles
  links = scraper.get_links

  top = 0
  (0...titles.size).each do |index|
    if top <= 10
        puts '---------------'
        puts titles[index]
        puts  URI("http://m.cnn.com#{links[index]}")
        top += 1
    else
        break
    end
  end

end
