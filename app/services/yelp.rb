class Yelp

  def get_json(uri, params = {})
    response = conn.get uri, params
    JSON.parse response.body, symbolize_names: true
  end

  private

  def conn
    Faraday.new('https://api.yelp.com') do |f|
      f.adapter Faraday.default_adapter
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end

end
