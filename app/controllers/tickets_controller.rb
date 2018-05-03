class TicketsController < ApplicationController
  rescue_from HTTParty::Error, with: :error

  def index
    @page = params[:page] || 1
    result = Ticket.ticket_list(@page)
    @tickets = result[:tickets]
    @num_of_pages = (result[:count].to_f / 25).ceil
  end

  def show
    @ticket = Ticket.single_ticket(params[:id])
  end

  def error
    render :error
  end
end


