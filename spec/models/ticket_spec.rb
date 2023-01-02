require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'relationships' do
    it { should have_many :employee_tickets }
    it { should have_many(:employees).through(:employee_tickets) }
  end

  it 'orders tickets from oldest to newest' do
    ticket_1 = Ticket.create!(subject: "printers broken", age: 5)
    ticket_2 = Ticket.create!(subject: "leaky faucet", age: 2)
    ticket_3 = Ticket.create!(subject: "desk broken", age: 8)
    ticket_4 = Ticket.create!(subject: "light out", age: 1)

    expect(Ticket.sort_by_oldest).to eq([ticket_3, ticket_1, ticket_2, ticket_4])
  end
end