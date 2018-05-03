require 'rspec'

require 'rails_helper'

describe Ticket do
  describe '.by_page' do
    subject { Ticket.ticket_list(5)[:tickets] }

    it 'returns 25 tickets for @urrent_page 5' do
      expect(subject.size).to eq 25
    end
  end

  describe '.single_ticket' do
    subject { Ticket.single_ticket(10) }

    it 'returns the ticket with id of 10' do
      expect(subject.id).to eq 10
    end
  end

end