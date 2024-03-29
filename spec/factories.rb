Factory.define :user do |user|
  user.name                  "Edwin"
  user.email                 "edwin@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micrpost do |micrpost|
  micrpost.content "Foo bar"
  micrpost.association :user
end