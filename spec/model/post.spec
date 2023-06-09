require 'rails_helper'

RSpec.describe Post, type: :model do
    let(:user) { User.create(name: "John Doe", photo: "test", bio: "The man") }

    describe "validations" do
        #title must not be blank.
        it "should have a title" do
            post = Post.create(title: nil, text: "test", comments_counter: 0, likes_counter: 0, author: user)
            expect(post).to_not be_valid

            post = Post.create(title: "test", text: "test", comments_counter: 0, likes_counter: 0, author: user)
            expect(post).to be_valid
        end

        #title must not exceed 100 characters.
        it "should have a title with length less than 250" do
            post = Post.new(title: "a" * 251, text: "test", comments_counter: 0, likes_counter: 0, author: user)
            expect(post).to_not be_valid

            post = Post.new(title: "a" * 249, text: "test", comments_counter: 0, likes_counter: 0, author: user)
            expect(post).to be_valid
        end

        #text must not be blank.
        it "should have a text" do
            post = Post.new(title: "test", text: "test", comments_counter: 0, likes_counter: 0, author: user)
            expect(post).to be_valid
        end

        #comments_counter and likes_counter must be 0. and numeric.
        it "should have a comments_counter and likes_counter" do
            post = Post.new(title: "test", text: "test", comments_counter: 0, likes_counter: 0, author: user)
            expect(post).to be_valid
        end
    end

    describe "associations" do
        #post should belong to an author.
        it "should belong to an author" do
            post = Post.reflect_on_association(:author)
            expect(post.macro).to eq(:belongs_to)
        end

        #post should have many comments.
        it "should have many comments" do
            post = Post.reflect_on_association(:comments)
            expect(post.macro).to eq(:has_many)
        end

        #post should have many likes.
        it "should have many likes" do
            post = Post.reflect_on_association(:likes)
            expect(post.macro).to eq(:has_many)
        end
    end
end