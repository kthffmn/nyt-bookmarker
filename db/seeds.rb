articles = JSON.parse(File.read("db/articles.json"))
i = 0
articles["results"].each_with_index do |article|
  Article.create(article)
  i += 1
end
puts "Seed: #{i} articles added"