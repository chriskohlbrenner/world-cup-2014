class MatchStat < ActiveRecord::Base
  belongs_to :match

  def self.json_data
    response = Net::HTTP.get_response('worldcup.sfg.io','/matches')
    JSON.parse(response.body)
  end

end
