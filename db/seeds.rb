# this seeds the database
class Seed
  URL = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key="
  ATTRIBUTES = ["url", "byline", "abstract", "title"]

  attr_reader :api_key, :data, :articles
  
  def initialize(api_key)
    @api_key = api_key
    @data = get_data
    @articles = self.data["results"]
  end

  def get_data
    url = URL + self.api_key
    JSON.load(open(url))
  end

  def run
    self.articles.each_with_object([]) do |article, array|
      Article.create(article)
    end
  end

end
