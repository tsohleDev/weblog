require 'rails_helper'

RSpec.describe Post, type: :request do
  describe '/users/1/posts' do
    context 'index url' do
      it 'should dispatch posts#index' do
        get user_posts_path(user_id: 1)
        expect(response).to render_template(:index)
      end

      it 'should include text "Listing posts"' do
        get user_posts_path(user_id: 1)
        expect(response.body).to include('Listing posts')
      end

      it 'should have have_http_status 200' do
        get user_posts_path(user_id: 1)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '/users/1/posts/show' do
    context 'show url' do
      it 'should dispatch posts#show' do
        get user_post_path(user_id: 1, id: 3)
        expect(response).to render_template(:show)
      end

      it 'should have params' do
        get '/users/1/posts/3'
        expect(response).to have_http_status(200)
      end

      it 'should include text "Showing post"' do
        get user_post_path(user_id: 1, id: 3)
        expect(response.body.include?('Showing post')).to be_truthy
      end
    end
  end
end
