require "rails_helper"

RSpec.describe RelatedTagsCreator do
  before :each do
    @travel_tag = Tag.first_or_create_with_name!("Travel")
    @sf_tag     = Tag.first_or_create_with_name!("San Francisco")
    @city_tag   = Tag.first_or_create_with_name!("City")
    RelatedTagsCreator.create([@travel_tag.id, @sf_tag.id])
  end

  it "creates association between tags" do
    expect(@travel_tag.related_tags).to include(@sf_tag)
    expect(@sf_tag.related_tags).to include(@travel_tag)
  end

  it "increments relevance by 1 everytime" do
    relationship = TagRelationship.where(tag_id: @travel_tag.id, related_tag_id: @sf_tag.id).first
    expect(relationship.relevance).to eq(1)

    RelatedTagsCreator.create([@travel_tag.id, @sf_tag.id, @city_tag.id])
    relationship.reload
    expect(relationship.relevance).to eq(2)
  end
end
