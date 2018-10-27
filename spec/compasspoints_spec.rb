require_relative '../compasspoints'
require 'matrix'

EXPECTED_HASHES = %w[MOVE_VECTORS NAMES LEFT_TURNS RIGHT_TURNS]
EXPECTED_DIRECTIONS = %i[north east south west]

def test_hash(hash_name)
  context "checking the hash #{hash_name}" do
    hash = CompassPoints.const_get(hash_name)
    it "should exist" do
      expect(hash.nil?).to eq false
    end
    it "should be immutable" do
      expect(hash.frozen?).to eq true
    end
    context "checking entries are present for all cardinal directions" do
      EXPECTED_DIRECTIONS.each {|direction|
        it "should have an entry for #{direction}" do
          expect(hash[direction].nil?).to eq false
      end
      }
    end
  end
end

describe CompassPoints do
  EXPECTED_HASHES.each { |name| test_hash(name) }
end
