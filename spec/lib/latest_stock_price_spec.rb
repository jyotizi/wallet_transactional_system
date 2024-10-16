require 'rails_helper'
require 'webmock/rspec'
require 'latest_stock_price'

RSpec.describe LatestStockPrice do
  let(:api_key) { "test_api_key" }
  let(:stock_price) { LatestStockPrice.new(api_key) }
  let(:base_url) { "https://rapidapi.com/suneetk92/api/latest-stock-price/" }

  describe "#price" do
    let(:stock_symbol) { "AAPL" }
    let(:price_response) { { "symbol" => stock_symbol, "price" => 145.30, "currency" => "USD" }.to_json }

    it "fetches the price of a stock" do
      stub_request(:get, "#{base_url}price/#{stock_symbol}")
        .with(headers: { 'x-rapidapi-key' => api_key })
        .to_return(status: 200, body: price_response, headers: { 'Content-Type' => 'application/json' })

      result = stock_price.price(stock_symbol)
      expect(result["symbol"]).to eq(stock_symbol)
      expect(result["price"]).to eq(145.30)
    end
  end

  describe "#prices" do
    let(:stock_symbols) { ["AAPL", "GOOGL"] }
    let(:prices_response) do
      [
        { "symbol" => "AAPL", "price" => 145.30, "currency" => "USD" },
        { "symbol" => "GOOGL", "price" => 2731.50, "currency" => "USD" }
      ].to_json
    end

    it "fetches the prices of multiple stocks" do
      stub_request(:get, "#{base_url}prices?symbols=#{stock_symbols.join(',')}")
        .with(headers: { 'x-rapidapi-key' => api_key })
        .to_return(status: 200, body: prices_response, headers: { 'Content-Type' => 'application/json' })

      result = stock_price.prices(stock_symbols)
      expect(result).to be_an(Array)
      expect(result.first["symbol"]).to eq("AAPL")
      expect(result.last["symbol"]).to eq("GOOGL")
    end
  end

  describe "#price_all" do
    let(:price_all_response) do
      [
        { "symbol" => "AAPL", "price" => 145.30, "currency" => "USD" },
        { "symbol" => "GOOGL", "price" => 2731.50, "currency" => "USD" }
      ].to_json
    end

    it "fetches the prices of all stocks" do
      stub_request(:get, "#{base_url}price_all")
        .with(headers: { 'x-rapidapi-key' => api_key })
        .to_return(status: 200, body: price_all_response, headers: { 'Content-Type' => 'application/json' })

      result = stock_price.price_all
      expect(result).to be_an(Array)
      expect(result.first["symbol"]).to eq("AAPL")
      expect(result.last["symbol"]).to eq("GOOGL")
    end
  end
end
