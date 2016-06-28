json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :trailer, :description, :featured
  json.url movie_url(movie, format: :json)
end
