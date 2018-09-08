class Oembed

  def initialize
    @conn = Faraday.new(:url => 'http://open.iframe.ly') do |faraday|
      faraday.request  :url_encoded   # form-encode POST params
      faraday.response :logger do | logger |
        logger.filter(/(api_key=)(\w+)/,'\1[REMOVED]')
      end
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get(path)
    response = @conn.get "/api/oembed?origin=https://github.com&url=#{URI.escape(path)}"     # GET http://sushi.com/nigiri/sake.json
    JSON.parse(response.body)
  end

end