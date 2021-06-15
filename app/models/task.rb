class Task < ApplicationRecord
	validates :task_name, presence: true
	scope :task_name_search, -> (query) {where("task_name LIKE ?", "%#{query}%")}
	def task_name_search(query)
	  where("task_name LIKE ?", "%#{query}%")
	end

	scope :status_search, -> (query) {where(status: query)}
	def status_search(query)
	  where(status: query)
	end
end
