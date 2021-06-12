class Task < ApplicationRecord
	validates :task_name, presence: true
	validates :deadline ,presence: true
end
