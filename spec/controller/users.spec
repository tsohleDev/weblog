require 'rails_helper'

RSpec.describe User, type: :request do
  describe '/' do
    context 'index url' do
      it 'should dispatch users#index' do
        get '/'
        expect(response).to render_template(:index)
      end
    end
  end

  describe '/users' do
    context 'index url' do
      it 'should dispatch users#index' do
        get '/users'
        expect(response).to render_template(:index)
      end

      it 'should include text "Listing users"' do
        get '/users'
        expect(response.body).to include('Listing users')
      end
    end
  end

  describe '/users/show' do
    context 'show url' do
      it 'should dispatch users#show' do
        get '/users/3'
        expect(response).to render_template(:show)
      end

      it 'should have params' do
        get '/users/3'
        expect(response).to have_http_status(200)
      end

      it 'should include text "Showing user"' do
        get '/users/3'
        expect(response.body.include?('Showing user')).to be_truthy
      end
    end
  end
end
