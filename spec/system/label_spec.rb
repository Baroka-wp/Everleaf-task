require 'rails_helper'
RSpec.describe 'Label management function', type: :system do
  describe 'New creation function' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user2)
      #@labelling = FactoryBot.create(:labelling)
      @label = FactoryBot.create(:label)
      @label2 = FactoryBot.create(:label2)
    end
    context 'When creating a new task' do
      it 'Multiple labels can be registered with it' do
        visit sessions_new_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        task = FactoryBot.create(:task, task_name: 'task1', priority: "high", user_id: @user.id)
        labellin1 = FactoryBot.create(:labelling, label_id: @label.id , task_id: task.id)
        labellin2 = FactoryBot.create(:labelling, label_id: @label2.id , task_id: task.id)
        visit tasks_path
        expect(page).to have_content 'task1'
      end
    end
    context 'When going on the task details screen' do
      it 'Output the list of labels associated with the task' do
        visit sessions_new_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        task = FactoryBot.create(:task, task_name: 'task1', priority: "high", user_id: @user.id)
        labellin1 = FactoryBot.create(:labelling, label_id: @label.id , task_id: task.id)
        labellin2 = FactoryBot.create(:labelling, label_id: @label2.id , task_id: task.id)
        visit task_path(task.id)
        expect(page).to have_content 'Label 1'
        expect(page).to have_content 'Label 2'
      end
    end
    context 'When you search for label' do
      it "Tasks contain the labels are narrowed down" do
        visit sessions_new_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button "Login"
        search_label = "Label 1"
        visit tasks_path(label_id: @label.id)
        expect(page).to have_content search_label
      end
    end
  end
end