class RelatedTagsCreator
  def self.create(tag_ids)
    id_permutation = tag_ids.repeated_permutation(2).reject { |ids| ids[0] == ids[1] }
    id_permutation.each do |ids|
      relationship = TagRelationship.where(tag_id: ids[0], related_tag_id: ids[1]).first_or_create
      relationship.increment(:relevance).save
    end
  end
end
