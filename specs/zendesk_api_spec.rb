require 'rspec'

require 'rails_helper'

describe ZendeskApi do
  let(:app) { ZendeskApi.new }

  describe '#tickets' do
    subject { app.tickets(5) }

    it 'returns Ticket objects' do
      item = subject[:tickets][0]
      expect(item).to be_an_instance_of Ticket
    end

    it 'converts my @urrent_page number to Zendesk @urrent_page number' do
      expect(subject[:zendesk_page]).to eq 2
    end
  end

  describe '#ticket' do
    subject { app.ticket(20) }

    it 'returns a Ticket object with ID of 20' do
      expect(subject).to be_an_instance_of Ticket
      expect(subject.id).to eq 20
    end
  end

end