class Ticket < ApplicationRecord
  has_many :employee_tickets
  has_many :employees, through: :employee_tickets

  def self.sort_by_oldest
    order(age: :desc)
  end
end