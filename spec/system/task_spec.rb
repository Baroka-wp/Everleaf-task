require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do
        visit new_task_path
        task = FactoryBot.create(:task, task_name: 'task')
        click_button "Register"
        expect(page).to have_content 'task'
      end
    end
  end
  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
        task = FactoryBot.create(:task, task_name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'When tasks are arranged in descending order of creation date and time' do
      it 'New task is displayed at the top' do
        task = FactoryBot.create(:task, task_name: 'task')
        visit tasks_path
        task_list = all('#task_row')
        expect(task.id).to eq task_list[0].id
      end
    end
  end
  describe 'Detailed display function' do
     context 'When transitioned to any task details screen' do
       it 'The content of the relevant task is displayed' do
        task = FactoryBot.create(:task, task_name: 'task')
        visit task_path(task.id)
        expect(page).to have_content 'task'
       end
     end
  end
end