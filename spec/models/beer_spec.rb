require 'rails_helper'

RSpec.describe Beer, type: :model do
  require 'rails_helper'

  describe "with a name and style set" do
    let(:beer) { Beer.create name: "A beer", style: "a style" }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  describe "with no name set" do
    let(:beer) { Beer.create style: "a style" }

    it "is not saved" do
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end

  describe "with no style set" do
    let(:beer) { Beer.create name: "a name" }

    it "is not saved" do
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end


end
