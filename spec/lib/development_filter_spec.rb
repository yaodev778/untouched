require 'rails_helper'
require 'development_filter'

describe DevelopmentFilter do
  context "with no options" do
    subject { DevelopmentFilter.new }
    let!(:development_1) { create(:development, photo: nil) }
    let!(:development_2) { create(:development, photo: nil) }

    it "returns one item for each development" do
      expect(subject.results.length).to eq(2)
    end

    describe "the first development result" do
      let(:least_expensive_unit) { development_1.units.order('price ASC').first }
      it "returns the least expensive unit" do
        expect(subject.results).to include(least_expensive_unit)
      end
    end

    describe "the second development result" do
      let(:least_expensive_unit) { development_2.units.order('price ASC').first }
      it "returns the least expensive unit" do
        expect(subject.results).to include(least_expensive_unit)
      end
    end
  end

  context "with number of bedrooms specified" do
    let!(:development) { create(:development, units_count: 0, photo: nil) }
    let!(:one_bedroom_unit) { create(:unit, bedrooms: 1, development: development) }
    let!(:two_bedroom_unit) { create(:unit, bedrooms: 2, development: development) }

    context "when 1 bedroom is specified" do
      subject { DevelopmentFilter.new(bedrooms: '1') }

      it "returns the one-bedroom unit" do
        expect(subject.results).to include(one_bedroom_unit)
      end
    end

    context "when 4 or more bedrooms are specified" do
      subject { DevelopmentFilter.new(bedrooms: '4+') }

      context "and there's only a 4-bedroom unit" do
        let!(:four_bedroom_unit) { create(:unit, bedrooms: 4, development: development) }
        it "returns the four-bedroom unit" do
          expect(subject.results).to include(four_bedroom_unit)
        end
      end

      context "and there's only a 5-bedroom unit" do
        let!(:five_bedroom_unit) { create(:unit, bedrooms: 5, development: development) }
        it "returns the five-bedroom unit" do
          expect(subject.results).to include(five_bedroom_unit)
        end
      end

    end
  end
end

