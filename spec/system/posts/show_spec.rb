require 'rails_helper'

RSpec.describe 'posts/show', type: :system do
  before(:all) do
    @user = User.create(name: 'John Doe',
                        photo: 'https://upload.wikimedia.org/wikipedia/commons/5/5a/John_Doe%2C_born_John_Nommensen_Duchac.jpg',
                        bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello1', text: 'This is my first post')
    comment_one = Comment.create(text: 'This is my first comment', author: @user, post: @post)
    comment_two = Comment.create(text: 'This is my second comment', author: @user, post: @post)
    comment_three = Comment.create(text: 'This is my third comment', author: @user, post: @post)
    @comments = [comment_one, comment_two, comment_three]
  end

  describe 'show url' do
    context 'posts' do
      it 'should show author name' do
        visit user_post_path(user_id: @user.id, id: @post.id)
        expect(page).to have_content(@post.author.name)
      end

      it 'should show posts titles' do
        visit user_post_path(user_id: @user.id, id: @post.id)
        expect(page).to have_content(@post.title)
      end

      it 'should show some of posts texts' do
        visit user_post_path(user_id: @user.id, id: @post.id)
        expect(page).to have_content(@post.text[0..99])
      end

      it 'should show posts comments count' do
        visit user_post_path(user_id: @user.id, id: @post.id)
        expect(page).to have_content("Comments: #{@post.comments.count}")
      end

      it 'should show posts likes count' do
        visit user_post_path(user_id: @user.id, id: @post.id)
        expect(page).to have_content("Likes: #{@post.likes.count}")
      end
    end

    context 'comments' do
      it 'should show comments author name' do
        visit user_post_path(user_id: @user.id, id: @post.id)
        @comments.each do |comment|
          expect(page).to have_content(comment.author.name)
        end
      end

      it 'should show comments text' do
        visit user_post_path(user_id: @user.id, id: @post.id)
        @comments.each do |comment|
          expect(page).to have_content(comment.text)
        end
      end
    end
  end
end
