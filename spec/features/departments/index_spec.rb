require 'rails_helper'

RSpec.describe 'Departments Index' do 
  describe 'As a user' do
    describe 'When I visit the Department index page' do
      before :each do
        @it = Department.create!(name: "IT", floor: 'Basement')
        @legal = Department.create!(name: "Legal", floor: 'Third')
        @sam = @it.employees.create!(name: "Sam", level: "1")
        @mat = @it.employees.create!(name: "mat", level: "1")
        @jim = @it.employees.create!(name: "Jim", level: "1")
        @bill = @legal.employees.create!(name: "Bill", level: "2")
        @sue = @legal.employees.create!(name: "Sue", level: "2")
        @pam = @legal.employees.create!(name: "Pam", level: "2")
        @larry = @legal.employees.create!(name: "Larry", level: "2")
      end
      it 'shows see each department name and floor' do
        visit '/departments'

        within "#department_#{@it.id}" do
          expect(page).to have_content(@it.name)
          expect(page).to have_content(@it.floor)
          expect(page).to_not have_content(@legal.name)
          expect(page).to_not have_content(@legal.floor)
        end
        
        within "#department_#{@legal.id}" do
          expect(page).to have_content(@legal.name)
          expect(page).to have_content(@legal.floor)
          expect(page).to_not have_content(@it.name)
          expect(page).to_not have_content(@it.floor)
        end
      end

      it 'underneath each department, I can see the names of all of its employees' do
        visit '/departments'

        within "#department_#{@it.id}" do
          expect(page).to have_content(@sam.name)
          expect(page).to have_content(@mat.name)
          expect(page).to have_content(@jim.name)
          expect(page).to_not have_content(@bill.name)
          expect(page).to_not have_content(@sue.name)
          expect(page).to_not have_content(@pam.name)
          expect(page).to_not have_content(@larry.name)
        end

        within "#department_#{@legal.id}" do
          expect(page).to_not have_content(@sam.name)
          expect(page).to_not have_content(@mat.name)
          expect(page).to_not have_content(@jim.name)
          expect(page).to have_content(@bill.name)
          expect(page).to have_content(@sue.name)
          expect(page).to have_content(@pam.name)
          expect(page).to have_content(@larry.name)
        end
      end
    end
  end
end