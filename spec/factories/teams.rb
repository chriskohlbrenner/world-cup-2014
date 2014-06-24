# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    api_id "A0CD1355-B6FC-48D3-B67B-AF5AA2B2C1E1"
    name "Croatia"
    logo "http://cache.images.globalsportsmedia.com/soccer/teams/150x150/514.png"
    website "http://www.hns-cff.hr/"
    group_letter "A"
    group_rank 3
    group_points 3
    matches_played 3
    wins 1
    losses 2
    draws 0
    goals_for 6
    goals_against 6
    goal_differential "+0"

    # raises NoMethodError: undefined method `matches_count' for #<FactoryGirl::SyntaxRunner:0x000001040e3e40>
    factory :team_with_matches do
      transient do
        matches_count 3
      end

      after(:create) do |team, evaluator|
        create_list(:post, evaluator.posts_count, team: team)
      end
    end
  end
end
