json.array!(@quotes) do |quote|
  json.extract! quote, :id, :author, :content, :hashtags
  json.url quote_url(quote, format: :json)
end
