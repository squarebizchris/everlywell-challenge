require "shorturl"

class Shortener
  def initialize(member)
    @member = member
  end

  # returns a shortened version of a members url
  def shorten_url
    url = ShortURL.shorten(@member.url, :tinyurl)
    return url
  end
end
