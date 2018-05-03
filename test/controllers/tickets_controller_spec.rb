require 'rspec'

require 'rails_helper'

describe TicketsController do
  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end

    it 'displays 25 tickets' do
      get :index
      expect(assigns(:tickets).size).to eq 25
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ticket to @ticket' do
      get :show, id: 10
      expect(assigns(:ticket).id).to eq 10
    end

    it 'renders the :show view' do
      get :show, id: 10
      expect(response).to render_template :show
    end
  end
end