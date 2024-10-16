require 'net/http'
require 'json'
require 'uri'

class LatestStockPrice
  BASE_URL = "https://rapidapi.com/suneetk92/api/latest-stock-price/".freeze

  def initialize(api_key)
    @api_key = api_key
  end

  def price(stock_symbol)
    fetch_data("price/#{stock_symbol}")
  end

  def prices(stock_symbols)
    fetch_data("prices?symbols=#{stock_symbols.join(',')}")
  end

  def price_all
    fetch_data("price_all")
  end

  private

  def fetch_data(endpoint)
    uri = URI.join(BASE_URL, endpoint)
    response = send_request(uri)

    parse_response(response)
  end

  def send_request(uri)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new(uri, headers)
      http.request(request)
    end
  end

  def headers
    { "x-rapidapi-key" => @api_key }
  end

  def parse_response(response)
    raise "API request failed with status #{response.code}" unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  rescue JSON::ParserError => e
    raise "Failed to parse JSON response: #{e.message}"
  end
end
