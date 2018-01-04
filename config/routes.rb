Rails.application.routes.draw do

  get 'authors/:lcnafid' => 'authors#view', as: :author
  get 'catalog/:id' => 'catalog#show', as: :catalog


  root 'application#home'

end
