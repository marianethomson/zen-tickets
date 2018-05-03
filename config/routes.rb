Rails.application.routes.draw do
    get '/' , to: "tickets#index"
    get '/page/:page', to: 'tickets#index'
    get '/ticket/:id', to:'tickets#show'
end
