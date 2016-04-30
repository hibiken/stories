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

class TagRelationship < ActiveRecord::Base
  belongs_to :tag
  belongs_to :related_tag, class_name: "Tag"
end
