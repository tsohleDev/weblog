require 'rails_helper'

RSpec.describe 'users/index', type: :system do
  before(:all) do
    @users = User.all
  end

  describe 'index url' do
    context 'users' do
      it 'should show users names' do
        visit users_path
        @users.each do |user|
          expect(page).to have_content(user.name)
        end
      end

      it 'should show users photos' do
        visit users_path
        @users.each do |user|
          expect(page).to have_css("img[src*='#{user.photo}']")
        end
      end

      it 'should show users posts count' do
        visit users_path
        @users.each do |user|
          expect(page).to have_content("Number of posts: #{user.posts.count}")
        end
      end
    end

    context 'click on user' do
      it 'should redirect to user profile page' do
        # click on first user name
        visit users_path
        first(:link, @users[0].name).click

        # check if we are on user profile page by url
        expect(page).to have_current_path(user_path(id: @users[0].id))
      end
    end
  end
end