FactoryGirl.define do
  factory :post do
    title 'post_params[:title]'
    description 'post_params[:description]'
    content 'post_params[:content] multitest'
    thumbnail 'thumbnail.png'
  end
  factory :post1 do
    title 'post_params[:title1]'
    description 'post_params[:description1]'
    content 'post_params[:content] multitest1'
    thumbnail 'thumbnail1.png'
  end
end