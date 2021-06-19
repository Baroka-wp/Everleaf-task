require 'date'

FactoryBot.define do
  factory :task do
    task_name { 'Title 1' }
    description { 'undefined' }
    deadline  { '2020/12/01' }
    status { 'completed' }
    association :user
  end

  factory :second_task, class: Task do
    task_name { 'Title 2' }
    description { 'undefined' }
    deadline { '2020/12/02' }
    status { 'unstarted' }
    association :user
  end
end