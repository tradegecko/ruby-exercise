# "Extracts the mentioned attributes or hash elements from the passed object and turns them into attributes of the JSON - rubydoc"
json.extract! @quote, :id, :author, :content, :hashtags, :created_at, :updated_at
