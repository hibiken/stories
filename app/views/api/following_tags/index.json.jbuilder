json.array! @tags do |tag|
  json.id tag.id
  json.name tag.name
  json.slug tag.slug
end
