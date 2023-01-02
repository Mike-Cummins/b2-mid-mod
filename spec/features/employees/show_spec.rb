require 'rails_helper'

RSpec.describe 'Employee Show' do 
  describe 'As a user' do
    describe 'When I visit an Employee show page' do
      before :each do
        @it = Department.create!(name: "IT", floor: 'Basement')
        @legal = Department.create!(name: "Legal", floor: 'Third')
        @sam = @it.employees.create!(name: "Sam", level: "1")
        @mat = @it.employees.create!(name: "mat", level: "1")
        @ticket_1 = @mat.tickets.create!(subject: "Mouse", age: 3)
        @ticket_2 = @mat.tickets.create!(subject: "Monitor", age: 1)
        @ticket_3 = @mat.tickets.create!(subject: "Phone", age: 5)


      end

      it 'Displays the employee name and department' do
        visit "/employees/#{@mat.id}"

        expect(page).to have_content(@mat.name)
        expect(page).to have_content(@it.name)
        expect(page).to_not have_content(@sam.name)
        expect(page).to_not have_content(@legal.name)
      end

      it 'Displays all tickets from oldest to newest' do
        visit "/employees/#{@mat.id}"
    
        expect(@ticket_3.subject).to appear_before(@ticket_1.subject)
        expect(@ticket_1.subject).to appear_before(@ticket_2.subject)
      end

      it 'Has another section that shows only the oldest ticket' do
        visit "/employees/#{@mat.id}"
save_and_open_page
        within "#oldest_ticket" do
          expect(page).to have_content(@ticket_3.subject)
        end
      end
    end
  end
end