require 'rails_helper'

RSpec.describe "posts/index", type: :system do
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

        @comments = Comment.all
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