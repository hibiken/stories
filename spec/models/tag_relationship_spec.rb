# == Schema Information
#
# Table name: tag_relationships
#
#  id             :integer          not null, primary key
#  tag_id         :integer          not null
#  related_tag_id :integer          not null
#  relevance      :integer          default("0"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe TagRelationship, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
