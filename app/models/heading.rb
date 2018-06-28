# == Schema Information
#
# Table name: headings
#
#  id          :integer          not null, primary key
#  member_id   :integer
#  header_text :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Heading < ApplicationRecord
  validates_presence_of :member_id, :header_text

  belongs_to :member
end
