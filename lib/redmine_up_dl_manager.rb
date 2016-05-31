Rails.configuration.to_prepare do
  require 'redmine_up_dl_manager/patches/application_helper_patch'
  require 'redmine_up_dl_manager/patches/attachments_helper_patch'
  require 'redmine_up_dl_manager/patches/attachments_controller_patch'
  require 'redmine_up_dl_manager/patches/user_patch'
end