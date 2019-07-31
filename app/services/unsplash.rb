class Unsplash < Base

  def image(query)
    get_json('photos/random', query: query)[:urls][:full]
  end

  private

  def conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.params[:client_id] = ENV['UNSPLASH_API_KEY']
      f.adapter Faraday.default_adapter
    end
  end
end
