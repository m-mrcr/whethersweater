class Unsplash
  def image(query)
    get_json('photos/random', query: query)[:urls][:full]
  end

  private

  def get_json(uri, params = {})
    response = conn.get(uri, params)
    JSON.parse response.body, symbolize_names: true
  end

  def conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.params[:client_id] = ENV['UNSPLASH_API_KEY']
      f.adapter Faraday.default_adapter
    end
  end
end
