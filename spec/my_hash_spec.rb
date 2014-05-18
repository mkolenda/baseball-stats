require_relative '../my_hash'

describe Hash do

  let(:record) { { key1: 'value 1', key2: 'value 2', data1: 'data 1', data2: 'data 2' } }

  it "should return true when all keys are present" do
    keys = [:key1, :key2]
    record.has_keys?(keys).should be_true
  end

  it "should return false when the record does not have the expected keys" do
    keys = [:key1, :key3]
    record.has_keys?(keys).should be_false
  end

  it "should return true if there are no keys to search for" do
    keys = []
    record.has_keys?(keys).should be_true

  end
end
