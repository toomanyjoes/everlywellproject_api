class Tinylink
  @api_key = "245d1e456d452fa928fd823700ffaecf14f9d749"
  @tool_url = "https://api-ssl.bitly.com/v4/shorten"
  def self.shorten(link)
    data = {
        "group_guid": "Bj3e8MP6rEx",
        "long_url": link,
    }
    uri = URI.parse(@tool_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.post(uri, data.to_json, {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@api_key}"})
    raise ApiExceptions::TinylinkError::ServerError.new unless response.kind_of? Net::HTTPSuccess
    return "http://#{JSON.parse(response.body)['id']}"
  end
end