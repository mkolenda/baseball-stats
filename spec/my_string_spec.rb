require_relative '../my_string'

describe String do

  let(:i) { "100" }
  let(:i_plus) { "+100" }
  let(:i_minus) { "-100" }
  let(:not_i) { "$100" }

  let(:f) { "0.00" }
  let(:f_plus) { "+0.00" }
  let(:f_minus) { "-0.00" }
  let(:not_f) { "0." }

  it "should say an i is an i" do
    i.is_i?.should be_true
  end

  it "should say an i with leading + is an i" do
    i_plus.is_i?.should be_true
  end

  it "should say an i with leading - is an i" do
    i_minus.is_i?.should be_true
  end

  it "should say an i with leading $ is not an i" do
    not_i.is_i?.should be_false
  end

  it "should say an f is an f" do
    f.is_f?.should be_true
  end

  it "should say an f with leading + is a f" do
    f_plus.is_f?.should be_true
  end

  it "should say an f with leading - is a f" do
    f_minus.is_f?.should be_true
  end

  it "should say an f with leading $ is not an f" do
    not_f.is_f?.should be_false
  end


end
