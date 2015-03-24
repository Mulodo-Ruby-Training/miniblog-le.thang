FactoryGirl.define do
  factory :post do
    title 'new post_params[:title]'
    description 'post_params[:description]'
    content 'post_params[:content] multitest'
    thumbnail 'thumbnail.png'
    user_id 1
    post_id 1
  end
end