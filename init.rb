require 'redmine'
require 'redmine_up_dl_manager'

Redmine::Plugin.register :redmine_up_dl_manager do
	requires_redmine :version_or_higher => "3.0.0"

  name 'Redmine Upload Download Manager'
  author 'Stephane Evrard'
  description 'A Redmine Plugin for managing and restricting user upload / download of files'
  version '0.1'
  
  menu :admin_menu, :up_dl_attachments, {:controller => 'up_dl_attachments', :action => 'index'}, :caption => :label_up_dl_attachment
end