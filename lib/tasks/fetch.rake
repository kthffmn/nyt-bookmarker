task :fetch do
  url = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key="
  data = JSON.load(open(url + ENV['NEW_YORK_TIMES_KEY']))
  i = 0
  data["results"].each do |article|
    title = article["title"]
    unless Article.find_by(:title => title)
      Article.create(
        :title => title,
        :byline => article["byline"],
        :abstract => article["abstract"],
        :url => article["url"]
      ) 
      i += 1
    end
  end
  if Article.count >= 500
    until Article.count == 500
      article = Article.first
      Bookmark.delete_associated_bookmarks(article)
      article.destroy
    end
  end
  puts "Fetch: #{i} articles added"
  puts "#{Article.count} total articles"
end