FactoryGirl.define do
  factory :comment do
    content "com_params[content]"
    user_id 1
    post_id 1
    parent_id 1
    comment_id 1
  end
end