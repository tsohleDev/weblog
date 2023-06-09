require 'rails_helper'

RSpec.describe Comment, type: :model do
    let(:user) { User.create(name: "John Doe", photo: "test", bio: "The man") }
    let(:post) { Post.create(title: "Who", text: "I am Jphn Doe", author: user) }

    describe "validations" do
        #text must not be blank.
        it "should have a text" do
            comment = Comment.create(text: nil, post: post, author: user)
            expect(comment).to_not be_valid

            comment = Comment.create(text: "test", post: post, author: user)
            expect(comment).to be_valid
        end

        #text must not exceed 100 characters.
        it "should have a text with length less than 100" do
            comment = Comment.new(text: "a" * 101, post: post, author: user)
            expect(comment).to_not be_valid

            comment = Comment.new(text: "a" * 99, post: post, author: user, )
            expect(comment).to be_valid
        end
    end

    describe "associations" do
        #should increment the post's comments_counter when a comment is created
        it "should increment the post's comments_counter when a comment is created" do
            expect { Comment.create(text: "test", post: post, author: user) }.to change { post.comments_counter }.by(1)
        end

        #should decrement the post's comments_counter when a comment is destroyed
        it "should decrement the post's comments_counter when a comment is destroyed" do
            comment = Comment.create(text: "test", post: post, author: user)
            expect { comment.destroy }.to change { post.comments_counter }.by(-1)
        end

        #should belong to an author
        it "should belong to an author" do
            comment = Comment.create(text: "test", post: post, author: user)
            expect(comment.author).to eq(user)
        end

        #should belong to a post
        it "should belong to a post" do
            comment = Comment.create(text: "test", post: post, author: user)
            expect(comment.post).to eq(post)
        end
    end
end