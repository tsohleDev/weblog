require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should have a name' do
      user = User.create
      expect(user).to_not be_valid

      user = User.create(name: 'Johny')
      expect(user).to be_valid
    end

    it 'should have a posts_counter' do
      user = User.create(name: 'Johny')
      expect(user.posts_counter).to eq(0)
    end

    it 'should have post_counter as numeric' do
      user = User.create(name: 'Johny')
      expect(user.posts_counter).to be_a_kind_of(Numeric)
    end
  end

  describe 'associations' do
    it 'should have many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'should have many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end

    it 'should have many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end
  end
end
