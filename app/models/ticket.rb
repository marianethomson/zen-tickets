class Ticket
  attr_accessor :id,
                :subject,
                :description,
                :requester_id,
                :assignee_id,
                :created_at,
                :updated_at,
                :status

  def initialize(id, subject, description, requester_id, assignee_id, created_at, updated_at, status)
    @id = id
    @subject = subject
    @description = description
    @requester_id = requester_id
    @assignee_id = assignee_id
    @created_at = created_at
    @updated_at = updated_at
    @status = status
  end

  PAGE_LIMIT = 25
  ZENDESK_RESPONSE = 100

  def self.ticket_list(page)
    api = ZendeskApi.new
    result = api.tickets(page)
    if result[:formatted_page] > 1
      start = 0 + (page.to_i - 1) * 25 - 100 * (result[:formatted_page] - 1)
    else
      start = 0 + (page.to_i - 1) * 25 # For @urrent_page 1 of results
    end
    tickets = result[:tickets]
    { tickets: tickets[start..start + 24], count: result[:count] }
  end

  def self.single_ticket(id)
    api = ZendeskApi.new
    api.ticket(id)
  end

end