require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  before do
    @task8 = FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do
        visit new_task_path
        date = DateTime.now.to_date
        task = FactoryBot.create(:task, task_name: 'task3', deadline: date )
        click_button "Register"
        visit tasks_path
        expect(page).to have_content 'task3'
        expect(page).to have_content date
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
        task1 = FactoryBot.create(:task, task_name: 'task1')
        task2 = FactoryBot.create(:task, task_name: 'task2')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0].text).to eq task2.task_name
      end
    end
    context 'When tasks are arranged in descending order of deadline date and time' do
      it 'Task with higher deadline is displayed at the top' do
        date0 = DateTime.now.to_date
        date1 = date0 + 2.day
        task4 = FactoryBot.create(:task, task_name: 'task4', deadline: date1)
        date2 = date0 + 1.day
        task5 = FactoryBot.create(:task, task_name: 'task5', deadline: date2)
        visit tasks_path(sort_expired: "true")
        task_list = all('.deadline_row')
        expect(task_list[0].text).to eq task4.deadline.to_s
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