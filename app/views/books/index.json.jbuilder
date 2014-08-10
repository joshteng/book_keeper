json.array!(@books) do |book|
  json.extract! book, :id, :company
  json.url book_url(book, format: :json)
end
