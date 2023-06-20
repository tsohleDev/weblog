require 'rails_helper'

RSpec.describe 'users/show', type: :system do
  before(:all) do
    @user = User.create(name: 'John Doe',
                        photo: 'https://upload.wikimedia.org/wikipedia/commons/5/5a/John_Doe%2C_born_John_Nommensen_Duchac.jpg',
                        bio: 'Teacher from Mexico.')
    post_one = Post.create(author: @user, title: 'Hello1', text: 'This is my first post')
    post_two = Post.create(author: @user, title: 'Hello2', text: 'This is my first post')
    post_three = Post.create(author: @user, title: 'Hello3', text: 'This is my first post')
    post_four = Post.create(author: @user, title: 'Hello4', text: 'This is my first post')
    post_five = Post.create(author: @user, title: 'Hello5', text: 'This is my first post')
    @posts = [post_one, post_two, post_three, post_four, post_five]
    @comments = Comment.all
  end

  describe 'show url' do
    context 'use info' do
      it 'should show user name' do
        visit user_path(@user.id)
        expect(page).to have_content(@user.name)
      end

      it 'should show user photo' do
        visit user_path(@user.id)
        expect(page).to have_css("img[src*='#{@user[:photo]}']")
      end

      it 'should show user bio' do
        visit user_path(@user.id)
        expect(page).to have_content(@user.bio)
      end

      it 'should show user posts count' do
        visit user_path(@user.id)
        expect(page).to have_content("Number of posts: #{@user[:posts_count]}")
      end
    end

    context 'see 3 last posts' do
      it 'should show posts titles' do
        visit user_path(@user.id)
        @posts[2..4].each do |post|
          expect(page).to have_content(post.title)
        end
      end

      it 'should show some of posts texts' do
        visit user_path(@user.id)
        @posts[0..2].each do |post|
          expect(page).to have_content(post.text[0..99])
        end
      end

      it 'should show posts comments count' do
        visit user_path(@user.id)
        @posts[0..2].each do |post|
          expect(page).to have_content("Comments: #{post.comments.count}")
        end
      end

      it 'should show posts likes count' do
        visit user_path(@user.id)
        @posts[0..2].each do |post|
          expect(page).to have_content("Likes: #{post.likes.count}")
        end
      end
    end

    context 'see click on post' do
      it 'should redirect to post page' do
        visit user_path(@user.id)

        # click on first post
        first(:link, @posts[3].title).click
        expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @posts[3].id))
      end
    end

    context 'see click on see all posts' do
      it 'should have see all posts link' do
        visit user_path(@user.id)
        expect(page).to have_link('See All Posts')
      end

      it 'should redirect to posts page' do
        visit user_path(@user.id)

        # click on first post
        click_link('See All Posts')
        expect(page).to have_current_path(user_posts_path(@user.id))
      end
    end
  end
end
