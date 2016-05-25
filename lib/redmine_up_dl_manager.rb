Rails.configuration.to_prepare do
  require 'redmine_up_dl_manager/patches/attachments_controller_patch'
end