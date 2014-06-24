# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match do
    api_id "F07CB601-072A-4B11-91D7-DD36ABE6E98A"
    start_time "2014-06-14T22:00:00.000Z"
    home_team_id "2EFCFEB2-EBF8-4628-B659-B00C49D93811"
    away_team_id "B61B25AA-CD8E-4778-AC26-DD08D7851990"
    home_score 1
    away_score 2
    status "Final"
    venue "Arena Amazônia (Manaus, Amazonas)"
    sequence(:order_id) { |n| n }
  end
end
