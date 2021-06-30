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

	scope :user_task_list, -> (query) {where(user_id: query)}
	def user_task_list(query)
	  where(user_id: query)
	end

	scope :label_task_search, -> (query) {
		@ids = Labelling.where(label_id: query).pluck(:task_id)
		where(id: @ids)}

	scope :priority_ordered, -> {order("
	    CASE tasks.priority 
	    WHEN 'high' THEN 'a' 
	    WHEN 'medium' THEN 'b' 
	    WHEN 'low' THEN 'c' 
	    ELSE 'z' 
	    END ASC, 
	    id DESC" )}
	max_paginates_per 5
	belongs_to :user
	has_many :labellings, dependent: :destroy
	has_many :labels, through: :labellings
end
