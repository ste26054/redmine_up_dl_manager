resources :up_dl_attachments

match 'up_dl_networks/new', :to => 'up_dl_attachments#network_new', :via => [:get, :post], as: :up_dl_networks_new
match 'up_dl_networks/create', :to => 'up_dl_attachments#network_create', :via => [:post], as: :up_dl_networks_create
match 'up_dl_networks/destroy/:id', :to => 'up_dl_attachments#network_destroy', :via => [:delete], as: :up_dl_networks_destroy
match 'up_dl_networks/edit/:id', :to => 'up_dl_attachments#network_edit', :via => [:get, :post, :patch], as: :up_dl_networks_edit
match 'up_dl_networks/update/:id', :to => 'up_dl_attachments#network_update', :via => [:post], as: :up_dl_networks_update