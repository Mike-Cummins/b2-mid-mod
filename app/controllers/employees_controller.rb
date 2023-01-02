class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
    @tickets = @employee.tickets.sort_by_oldest
    @oldest_ticket = @tickets.first
  end
end