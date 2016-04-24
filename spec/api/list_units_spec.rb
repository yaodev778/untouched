require 'rails_helper'

describe "listing units for a given development", type: :api do

  def do_get
    get "/api/developments/#{development.id}/units", format: :json
  end

  def parsed_response
    JSON.parse last_response.body
  end

  context "with no units" do
    let(:development) { create(:development, units_count: 0) }

    it "is an empty set" do
      do_get
      expect(parsed_response['units']).to eql([])
    end
  end

  context "with one unit" do
    let(:development) { create(:development, units_count: 1) }

    it "includes the unit in the response" do
      do_get
      expect(parsed_response['units'].length).to eq(1)
    end
  end

end
