class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
    @tickets = @employee.tickets.sort_by_oldest
    @oldest_ticket = @tickets.first
  end

  def update
    employee = Employee.find(params[:id])
    new_ticket = Ticket.find(params[:ticket_id])
    EmployeeTicket.create!(employee: employee, ticket: new_ticket)

    redirect_to "/employees/#{employee.id}"
  end
end