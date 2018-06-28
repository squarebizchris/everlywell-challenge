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
  validates :name, :url, presence: true
end
