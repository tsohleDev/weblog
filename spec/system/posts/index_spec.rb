require 'rails_helper'

RSpec.describe 'posts/index', type: :system do
  before(:all) do
    @user = User.create(name: 'John Doe',
                        photo: 'https://upload.wikimedia.org/wikipedia/commons/5/5a/John_Doe%2C_born_John_Nommensen_Duchac.jpg',
                        bio: 'Teacher from Mexico.')
    post1 = Post.create(author: @user, title: 'Hello1', text: 'This is my first post')
    post2 = Post.create(author: @user, title: 'Hello2', text: 'This is my first post')
    post3 = Post.create(author: @user, title: 'Hello3', text: 'This is my first post')
    post4 = Post.create(author: @user, title: 'Hello4', text: 'This is my first post')
    post5 = Post.create(author: @user, title: 'Hello5', text: 'This is my first post')
    @posts = [post1, post2, post3, post4, post5]

    comment_one = Comment.create(text: 'This is my first comment', author: @user, post: post1)
    comment_two = Comment.create(text: 'This is my second comment', author: @user, post: post2)
    comment_three = Comment.create(text: 'This is my third comment', author: @user, post: post3)
    comment_four = Comment.create(text: 'This is my fourth comment', author: @user, post: post4)
    comment_five = Comment.create(text: 'This is my fifth comment', author: @user, post: post5)
    @comments = [comment_one, comment_two, comment_three, comment_four, comment_five]
  end

  describe 'posts url' do
    context 'user profile' do
      it 'should show user\'s name' do
        visit user_posts_path(user_id: @user.id)
        expect(page).to have_content(@user.name)
      end

      it 'should show user\'s posts count' do
        visit user_posts_path(user_id: @user.id)
        expect(page).to have_content("Number of posts: #{@posts.count}")
      end

      it 'should show user\'s avatar image' do
        visit user_posts_path(user_id: @user.id)
        expect(page).to have_css("img[src*='#{@user[:photo]}']")
      end
    end

    context 'post list' do
      it 'should redirect to post show page' do
        # click on first post title
        visit user_posts_path(user_id: @user.id)
        first(:link, @posts[0].title).click

        # check if we are on show page by url
        expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @posts[0].id))
      end

      it 'should show some text from post' do
        visit user_posts_path(user_id: @user.id)
        @posts.each do |post|
          expect(page).to have_content(post.text[0..99])
        end
      end

      it 'should show number of comments' do
        visit user_posts_path(user_id: @user.id)
        @posts.each do |post|
          expect(page).to have_content("Comments: #{post.comments.count}")
        end
      end

      it 'should show first comment only' do
        visit user_posts_path(user_id: @user.id)
        expect(page).to have_content(@comments[0].text)
      end

      it 'should show number of likes' do
        visit user_posts_path(user_id: @user.id)
        @posts.each do |post|
          expect(page).to have_content("Likes: #{post.likes.count}")
        end
      end
    end

    context 'pagination' do
      it 'should show 3 posts per page' do
        visit user_posts_path(user_id: @user.id)
        expect(page).to have_selector('div.post', count: 3)
      end

      it 'should show pagination link if there are more than 3 posts' do
        visit user_posts_path(user_id: @user.id)
        expect(page).to have_content('Pagination')
      end
    end
  end
end
