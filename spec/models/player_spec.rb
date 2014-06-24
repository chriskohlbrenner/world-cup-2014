require 'rails_helper'

describe Player do
  it 'has a valid factory' do
    expect(build(:player)).to be_valid
  end

  let(:wayne_rooney) {FactoryGirl.create(:player)}

  describe '#full_name' do
    it 'returns player\'s full name' do
      expect(wayne_rooney.full_name).to eq("Wayne Rooney")
    end
  end

  describe '#group' do
    it 'returns group object' do
      pending('pending until test can retrieve group object')
      this_should_not_get_executed
    end
  end
end