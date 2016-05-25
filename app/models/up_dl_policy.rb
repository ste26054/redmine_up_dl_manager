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
    # get policies associated to user for which ip_str does not match ip_list of the policy.
    ip_str_in_iplist_by_policy = user.up_dl_policies.inject({}) { |h, (k, v)| h[k] = UpDlNetwork.is_ip_in_iplist?(ip_str, k.ip_list); h }.select{|k,v| v == false}.keys

    # take the max among upload and download policies: Higher enum values = more restrictive
    overall_upload_policy = ip_str_in_iplist_by_policy.max_by{|a| UpDlPolicy.upload_policies[a.upload_policy]}.try(:upload_policy)
    overall_download_policy = ip_str_in_iplist_by_policy.max_by{|a| UpDlPolicy.download_policies[a.download_policy]}.try(:download_policy)

    overall_upload_policy ||= 0
    overall_download_policy ||= 0

    return UpDlPolicy.new(upload_policy: overall_upload_policy, download_policy: overall_download_policy, scope: :global)
  end

  # returns the list of ips associated to up_dl_networks of the policy
  def ip_list
    return self.up_dl_networks.map(&:ip_list).flatten
  end
end