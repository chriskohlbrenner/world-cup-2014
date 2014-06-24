# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    first_name "Wayne"
    last_name "Rooney"
    nickname "W. Rooney"
    nationality "England"
    age 28
    birth_date "1985-10-24T00:00:00.000Z"
    birth_country "England"
    birth_city "Liverpool"
    position "Attacker"
    foot "Right"
    image "http://cache.images.globalsportsmedia.com/soccer/players/150x150/193.png"
    height_cm 176
    weight_kg 78
    goals 1
    own_goals 0
    penalty_goals 0
    assists 1
    club_id "7D34FC43-AD14-454C-A815-DD8B833C0CF5"
    team_api_id "2EFCFEB2-EBF8-4628-B659-B00C49D93811"
    api_id "1051AFD7-0678-4ED2-90EE-7DD0A86D73FA"
    type "Player"
  end
end
