require_relative '../../lib/carry_calculator/carry_calculator'


RSpec.describe CarryCalculator do
  let(:calc) { CarryCalculator.new }

  describe "adding containers" do

    it "allows containers to be added" do
      result = calc.add_container("con",1)
      expect(result.success?).to be true
    end

    it "rejects 0 sized containers" do
      result = calc.add_container("con",0)
      expect(result.success?).to be false
      expect(result.message).to match("invalid container")
    end

    it "rejects nonnumeric sized containers" do
      result = calc.add_container("con","0")
      expect(result.success?).to be false
      expect(result.message).to match("invalid container")
    end

    it "rejects unnamed containers" do
      result = calc.add_container(nil,0)
      expect(result.success?).to be false
      expect(result.message).to match("invalid container")
    end
  end


  describe "preprocessing" do
    it "returns an error if no containers" do
      result = calc.preprocess
      expect(result.success?).to be false
      expect(result.message).to match "no containers to process"
    end

    it "returns success if there's containers" do
      calc.add_container("con",1)

      result = calc.preprocess
      expect(result.success?).to be true
      expect(result.message).to match "preprocessed"
    end
  end


  describe "get manifest" do
    let(:prepped_calc) do
      calc.add_container("2", 2)
      calc.add_container("5", 5)
      calc.add_container("7", 7)
      calc.add_container("9", 9)
      calc.add_container("11", 11)
      calc.preprocess
      calc
    end

    it "returns [1, 0] when first capacity requested" do
      result = prepped_calc.get_manifest(2)
      expect(result).to eq([1, 0, 0, 0, 0])
    end

    it "returns [0, 1] when second capacity requested" do
      result = prepped_calc.get_manifest(5)
      expect(result).to eq([0, 1, 0, 0, 0])
    end

    it "returns nil when unavailable capacity requested" do
      result = prepped_calc.get_manifest(3)
      expect(result).to eq(nil)
    end

    it "returns the better(minimizes total elements) answer when possible" do
      result = prepped_calc.get_manifest(20)
      expect(result).to eq([0, 0, 0, 1, 1])
    end
  end

end