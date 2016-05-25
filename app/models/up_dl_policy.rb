class UpDlPolicy < ActiveRecord::Base
  has_many :up_dl_policy_networks
  has_many :up_dl_policy_users

end