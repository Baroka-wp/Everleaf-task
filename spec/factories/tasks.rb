require 'date'

FactoryBot.define do
  factory :task do
    task_name { 'Title 1 made by Factory' }
    description { 'undefined' }
    deadline  { '2020/12/01' }
  end

  factory :second_task, class: Task do
    task_name { 'Title 2 made by Factory' }
    description { 'undefined' }
    deadline { '2020/12/02' }
  end
end