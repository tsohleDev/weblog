require 'rails_helper'

RSpec.describe Like, type: :model do
    let(:user) { User.create(name: "John Doe", photo: "test", bio: "The man") }
    let(:post) { Post.create(title: "Who", text: "I am Jphn Doe", author: user) }

    describe "associations" do
        #should belong to an author
        it "should belong to an author" do
            like = Like.create(author: user, post: post)
            expect(like.author).to eq(user)
        end

        #should belong to a post
        it "should belong to a post" do
            like = Like.create(author: user, post: post)
            expect(like.post).to eq(post)
        end
    end

    describe "validations" do
        #should validate uniqueness of author_id scoped to post_id
        it "should validate uniqueness of author_id scoped to post_id" do
            like = Like.create(author: user, post: post)
            expect(like).to be_valid

            like = Like.create(author: user, post: post)
            expect(like).to_not be_valid
        end
    end
end