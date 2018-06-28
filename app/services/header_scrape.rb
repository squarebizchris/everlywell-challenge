require "nokogiri"
require "open-uri"

class HeaderScrape
  def initialize(member)
    @member = member
  end

  # returns an array of collections of header values
  def grab_headers
    headers = []
    begin
      page = Nokogiri::HTML(open(@member.url))
      ["h1", "h2", "h3"].each do |header|
        headers << extract_header(page, header)
      end
    rescue
      # TODO: Add better error handling
      puts "page not loaded"
    end
    return headers.flatten
  end

  private

  # returns an array of header text
  def extract_header(page, header_val)
    headers = page.css(header_val)
    return headers.map(&:text)
  end
end
