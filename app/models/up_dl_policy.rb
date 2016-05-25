class UpDlPolicy < ActiveRecord::Base
  has_many :up_dl_policy_networks
  has_many :up_dl_policy_users

  enum upload_policy: { allowed: 0, denied: 1 }
  enum download_policy: { allowed: 0, denied_but_images: 1 }
  enum scope: { global: 0 }
end