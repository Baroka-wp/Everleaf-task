require 'rails_helper'
RSpec.describe 'User management function', type: :system do 
  describe 'User creation function' do
    context 'When creating a new user' do
      it 'User is registered' do
        visit new_user_path
        fill_in 'name', with: 'user1'
        fill_in 'email', with: 'user1@dive.l'
        fill_in 'password', with: '123456'
        fill_in 'password_confirmation', with: '123456'
        click_button "Register"
        expect(page).to have_content 'Tasks index'
      end
    end
    context 'When the user tries to jump to the task list screen without logging' do
      it 'Transition to the login screen' do
        visit tasks_path
        expect(page).to have_content 'Log In'
      end
    end
  end
  describe 'Testing session functionality' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user2)
    end
    context 'When user tries login' do
      it 'Login is a success' do
        visit sessions_new_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        expect(page).to have_content 'Tasks index'
      end
    end
    context 'When the user tries to jump to your details screen' do
      it 'You can jump to your details screen' do
        visit sessions_new_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        visit user_path(@user.id)
        expect(page).to have_content 'Welcome to your page'
      end
    end
    context 'When a general user jumps to another person\'s details screen' do
      it 'It will transition to the task list screen' do
        visit sessions_new_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        visit user_path(@user2.id)
        expect(page).to have_content 'Tasks index'
      end
    end
    context 'When the user tries to logout' do
      it 'Logout successfully' do
        visit sessions_new_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        click_link "Logout"
        expect(page).to have_content 'Sign up'
      end
    end
  end
  describe 'Admin screen test function' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user2)
      @admin = FactoryBot.create(:admin)
    end
    context 'When admin tries to access admin screen' do
      it 'Admin screen is successfully displayed' do
        visit sessions_new_path
        fill_in 'email', with: @admin.email
        fill_in 'password', with: @admin.password
        click_button "Login"
        visit admin_users_path
        expect(page).to have_content 'Users list'
      end
    end
    context 'When general user tries to access admin screen' do
      it 'Admin screen is not displayed' do
        visit sessions_new_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        visit admin_users_path
        expect(page).to have_content 'Tasks index'
      end
    end
    context 'When admin tries to register new user' do
      it 'Admin can register user successfully' do
        visit sessions_new_path
        fill_in 'email', with: @admin.email
        fill_in 'password', with: @admin.password
        click_button "Login"
        visit new_admin_user_path
        fill_in 'name', with: 'user3'
        fill_in 'email', with: 'user3@dive.l'
        fill_in 'password', with: '1234567'
        fill_in 'password_confirmation', with: '1234567'
        click_button "Register"
        expect(page).to have_content 'Users list'
      end
    end
    context 'When admin tries to access the user details screen' do
      it 'The user details screen is successfully displayed' do
        visit sessions_new_path
        fill_in 'email', with: @admin.email
        fill_in 'password', with: @admin.password
        click_button "Login"
        visit admin_user_path(@user.id)
        expect(page).to have_content 'Tasks of '+@user.name
      end
    end
    context 'When admin tries to edit the user' do
      it 'The user edit screen is successfully displayed' do
        visit sessions_new_path
        fill_in 'email', with: @admin.email
        fill_in 'password', with: @admin.password
        click_button "Login"
        visit edit_admin_user_path(@user.id)
        expect(page).to have_content 'Edit the user'
      end
    end
    context 'When admin tries to delete a user' do
      it 'The user is deleted successfully' do
        visit sessions_new_path
        fill_in 'email', with: @admin.email
        fill_in 'password', with: @admin.password
        click_button "Login"
        visit admin_users_path
        click_on "delete#{@user2.id}"
        expect(page).to_not have_content @user2.id
      end
    end
  end
end