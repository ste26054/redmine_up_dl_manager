class UpDlPolicy < ActiveRecord::Base
  has_many :up_dl_policy_networks, dependent: :destroy
  has_many :up_dl_networks, through: :up_dl_policy_networks
  has_many :up_dl_policy_users, dependent: :destroy
  has_many :users, through: :up_dl_policy_users

  enum upload_policy: { up_allowed: 0, up_denied: 1 }
  enum download_policy: { dl_allowed: 0, dl_denied_but_images: 1 }
  enum scope: { global: 0 }

  attr_accessible :upload_policy, :download_policy, :scope, :description

  # returns overall policy for given user, ip
  def self.overall_policy_for_user_with_ip(user, ip_str)
    # get list of policy => networks_ips for given user
    ips_by_policy = user.up_dl_policies.map{ |p| { p => p.ip_list } }

  end

  # returns the list of ips associated to up_dl_networks of the policy
  def ip_list
    return self.up_dl_networks.map(&:ip_list).flatten
  end
end