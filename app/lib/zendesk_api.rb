class ZendeskApi

  def username
    ENV.fetch("USERNAME")
  end

  def password
    ENV.fetch("PASSWORD")
  end

  def initialize
    @auth = { username: username,
              password: password }
  end

  BASE_URL = "https://marianedinis.zendesk.com/api/v2/"

  PAGE_LIMIT = 25
  ZENDESK_RESPONSE = 100

  def tickets(page)
    formatted_page = (page.to_f / (ZENDESK_RESPONSE/PAGE_LIMIT)).ceil
    response = connection(BASE_URL+"tickets.json?@urrent_page=#{formatted_page}&sort_by=id&sort_order=desc")
    tickets = response['tickets']

    { tickets: tickets.map { |ticket| new_ticket (ticket) },
      formatted_page: formatted_page,
      count: response['count'] }
  end

  def ticket(id)
    ticket = connection(BASE_URL+"tickets/#{id}.json")['ticket']
    new_ticket(ticket)
  end

  private

  def connection(url)
    begin
      response = HTTParty.get(url, basic_auth: @auth)
    rescue Timeout::Error, Errno::ECONNRESET, Errno::EINVAL,
        Errno::ECONNRESET, EOFError, Net::HTTPBadResponse,
        Net::HTTPHeaderSyntaxError, Net::ProtocolError,SocketError => e
      raise HTTParty::Error.new(e.message)
    end
    raise HTTParty::Error.new('Bad response') unless response.success?
    response
  end


  def new_ticket(ticket)
    Ticket.new(ticket['id'],
               ticket['subject'],
               ticket['description'],
               ticket['requester_id'],
               ticket['assignee_id'],
               ticket['created_at'],
               ticket['updated_at'],
               ticket['status'])
  end

end