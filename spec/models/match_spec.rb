require 'spec_helper'

describe Match do
  it 'has a valid factory' do
    expect(build(:match)).to be_valid
  end

  let(:final_win) { FactoryGirl.create(:match, :status => 'Final') }
  let(:final_draw) { FactoryGirl.create(:match, :status => 'Final', :home_score => 1, :away_score => 1) }
  let(:in_progress) {FactoryGirl.create(:match, :status=> 'In-progress')}
  let(:pre_game) { FactoryGirl.create(:match, :status=> 'Pre-game') }

  describe '.matches_in_progress' do
    context 'when there are matches in progress' do
      it 'returns the match object' do
        expect(Match.matches_in_progress).to match_array(in_progress)
      end
    end
  end

  describe '.next_matches' do
    context 'when there is an upcoming match' do
      it 'returns that match object' do
        expect(Match.next_matches(1)).to match_array(pre_game)
      end
    end
  end

  describe '.previous_matches' do
    context 'when there is a previous match' do
      it 'returns that match object' do
        expect(Match.previous_matches(2)).to match_array([final_win, final_draw])
      end
    end
  end

  describe '#display_time' do
    it 'correctly formats the match time' do
      expect(pre_game.display_time).to eq("Saturday, June 14, at  6:00 PM EDT")
    end
  end

  describe '#winner?' do
    context 'when there is a winner' do
      it 'returns true' do
        expect(final_win.winner?).to be_truthy
      end
    end

    context 'when there is no winner' do
      it 'returns false' do
        expect(final_draw.winner?).to be_falsey
      end
    end
  end

  describe '#winner' do
    context 'when there is a winner' do
      it 'returns team that won match' do
        pending("pending until test can retrieve team object")
        this_should_not_get_executed
      end
    end
    context 'when there is no winner' do
      it 'returns nil' do
        expect(final_draw.winner).to be_nil
      end
    end
  end

  describe '#loser' do
    context 'when there is a loser' do
      it 'returns team that lost match' do
        pending("pending until test can retrieve team object")
        this_should_not_get_executed
      end
    end
    context 'when there is no loser' do
      it 'returns nil' do
        expect(final_draw.loser).to be_nil
      end
    end
  end

  describe '#goals' do
    it 'returns all goal match_stat objects for the match' do
      pending("pending until test can retrieve match_stat objects")
      this_should_not_get_executed
    end
  end
end