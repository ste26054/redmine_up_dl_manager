resources :up_dl_attachments

match 'up_dl_networks/new', :to => 'up_dl_attachments#network_new', :via => [:get, :post], as: :up_dl_networks_new
match 'up_dl_networks/create', :to => 'up_dl_attachments#network_create', :via => [:post], as: :up_dl_networks_create
match 'up_dl_networks/destroy/:id', :to => 'up_dl_attachments#network_destroy', :via => [:delete], as: :up_dl_networks_destroy
match 'up_dl_networks/edit/:id', :to => 'up_dl_attachments#network_edit', :via => [:get, :post, :patch], as: :up_dl_networks_edit
match 'up_dl_networks/update/:id', :to => 'up_dl_attachments#network_update', :via => [:post, :patch], as: :up_dl_networks_update

match 'up_dl_policies/new', :to => 'up_dl_attachments#new', :via => [:get, :post], as: :up_dl_policies_new
match 'up_dl_policies/create', :to => 'up_dl_attachments#create', :via => [:post], as: :up_dl_policies_create
match 'up_dl_policies/destroy/:id', :to => 'up_dl_attachments#destroy', :via => [:delete], as: :up_dl_policies_destroy
match 'up_dl_policies/edit/:id', :to => 'up_dl_attachments#edit', :via => [:get, :post, :patch], as: :up_dl_policies_edit
match 'up_dl_policies/update/:id', :to => 'up_dl_attachments#update', :via => [:post, :patch], as: :up_dl_policies_update