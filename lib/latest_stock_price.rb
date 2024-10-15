require 'httparty'

class LatestStockPrice
  include HTTParty
  base_uri 'https://latest-stock-price.p.rapidapi.com'

  def initialize
    @headers = {
      "x-rapidapi-host" => "latest-stock-price.p.rapidapi.com",
      "x-rapidapi-key" => "YOUR_RAPIDAPI_KEY"
    }
  end

  def price(symbol)
    self.class.get("/price?symbol=#{symbol}", headers: @headers)
  end

  def prices(symbols)
    self.class.get("/prices?symbols=#{symbols.join(',')}", headers: @headers)
  end

  def price_all
    self.class.get("/price_all", headers: @headers)
  end
end
