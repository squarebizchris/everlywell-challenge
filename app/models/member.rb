# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :text
#  short_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Member < ApplicationRecord
  after_create :scrape_headers, :shorten_url

  validates :name, :url, presence: true

  has_many :headings

  private

  def scrape_headers
    scrape = HeaderScrape.new(self)
    headers = scrape.grab_headers
    headers.map{|h| self.headings.create(header_text: h) }
  end

  def shorten_url
    shortner = Shortener.new(self)
    self.update_attribute(:short_url, shortner.shorten_url)
  end
end
