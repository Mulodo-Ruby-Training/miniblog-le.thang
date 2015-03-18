FactoryGirl.define do
  factory :post do
    title 'post_params[:title]'
    description 'post_params[:description]'
    content 'post_params[:content] multitest'
    thumbnail 'thumbnail.png'
  end
end