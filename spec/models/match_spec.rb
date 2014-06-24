require 'spec_helper'

describe Match do
  it 'has a valid factory' do
    expect(build(:match)).to be_valid
  end

  let(:final) { FactoryGirl.create(:match, :status => 'Final') }
  let(:in_progress) {FactoryGirl.create(:match, :status=> 'In-progress')}
  let(:pre_game) { FactoryGirl.create(:match, :status=> 'Pre-game') }

  describe '.matches_in_progress' do
    context 'when there are matches in progress' do
      it 'returns the match object' do
        expect(Match.matches_in_progress).to eq([in_progress])
      end
    end
  end

  describe 'next_match' do
    context 'when there is an upcoming match' do
      it 'returns that match object' do
        expect(Match.next_match).to eq(pre_game)
      end
    end
  end

end