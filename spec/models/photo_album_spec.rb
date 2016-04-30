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

require 'rails_helper'

RSpec.describe PhotoAlbum, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
