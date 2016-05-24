require 'redmine'

Redmine::Plugin.register :redmine_up_dl_manager do
	requires_redmine :version_or_higher => "3.0.0"

  name 'Redmine Upload Download Manager'
  author 'Stephane Evrard'
  description 'A Redmine Plugin for managing and restricting user upload / download of files'
  version '0.1'
  
end