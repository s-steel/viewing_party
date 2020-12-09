require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  describe 'when I visit my user dashboard' do
    describe 'if I don\'t have any friends' do
      before :each do
        @user = create(:user)
        @user_2 = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit dashboard_path
      end

      it 'I see a search field and button within the friend section' do
        within '.friends' do
          expect(page).to have_field(:friend_search)
          expect(page).to have_button('Add Friend')
        end
      end

      it 'I don\'t see any friends' do
        within '.friends' do
          expect(page).to have_content('You currently have no friends')
        end
      end

      it 'I can add a friend who exists in the system' do
        within '.friends' do
          fill_in :friend_search, with: @user_2.user_name
          click_button 'Add Friend'
        end
        within '.friends' do
          expect(page).to_not have_content('You currently have no friends')
          expect(page).to have_content(@user_2.user_name)
        end
      end

      it 'I can add a friend who exists in the system using their email' do
        within '.friends' do
          fill_in :friend_search, with: @user_2.email
          click_button 'Add Friend'
        end
        within '.friends' do
          expect(page).to_not have_content('You currently have no friends')
          expect(page).to have_content(@user_2.user_name)
        end
      end

      it 'I cannot add a friend who doesn\'t exist in the system' do
        within '.friends' do
          fill_in :friend_search, with: 'random_person'
          click_button 'Add Friend'
        end
        expect(page).to have_content('That user doesn\'t exist in the system')
        within '.friends' do
          expect(page).to have_content('You currently have no friends')
        end
      end

      it 'I cannot add a friend using an incorrect email' do
        within '.friends' do
          fill_in :friend_search, with: (@user_2.user_name + '.com')
          click_button 'Add Friend'
        end
        expect(page).to have_content('That user doesn\'t exist in the system')
      end

      it 'I cannot add myself as a friend' do
        within '.friends' do
          fill_in :friend_search, with: @user.user_name
          click_button 'Add Friend'
        end
        expect(page).to have_content('You cannot add yourself as a friend')
        within '.friends' do
          expect(page).to have_content('You currently have no friends')
        end
      end

      it 'a blank search field doesn\'t return anything new' do
        within '.friends' do
          click_button 'Add Friend'
        end
        expect(page).to_not have_content('That user doesn\'t exist in the system')
        expect(page).to_not have_content('You cannot add yourself as a friend')
        within '.friends' do
          expect(page).to have_content('You currently have no friends')
        end
      end
    end

    describe 'If I do have friends' do
      it 'I see my list of friends on my dashboard' do
        @user = create(:user, :with_friends)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        @friend_1 = @user.followed.first
        @friend_2 = @user.followed.second
        @friend_3 = @user.followed.third

        visit dashboard_path

        within '.friends' do
          expect(page).to_not have_content('You currently have no friends')
          expect(page).to have_content(@friend_1.user_name)
          expect(page).to have_content(@friend_2.user_name)
          expect(page).to have_content(@friend_3.user_name)
        end
      end
    end
  end
end
