# == Schema Information
#
# Table name: photo_albums
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  photos      :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PhotoAlbum < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user
end
