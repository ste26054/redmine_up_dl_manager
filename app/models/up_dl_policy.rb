class UpDlPolicy < ActiveRecord::Base
  has_many :up_dl_policy_networks, dependent: :destroy
  has_many :up_dl_networks, through: :up_dl_policy_networks
  has_many :up_dl_policy_users, dependent: :destroy
  has_many :users, through: :up_dl_policy_users

  enum upload_policy: { upload_allowed: 0, upload_denied: 1 }
  enum download_policy: { download_allowed: 0, download_denied_except_inline_images: 1 }
  enum scope_policy: { global: 0 }
  enum applicability_policy: { not_in_network_list: 0, in_network_list: 1 }

  validates :is_for_all_users, inclusion: [true, false]

  attr_accessible :upload_policy, :download_policy, :scope_policy, :description, :up_dl_networks_attributes, :users_attributes, :applicability_policy, :is_for_all_users


  def up_dl_networks_attributes
    if self.id
      @up_dl_networks_attributes = self.up_dl_networks
    else
      @up_dl_networks_attributes
    end
  end

  def up_dl_networks_attributes=(network_ids)
    network_ids_sanitized = UpDlNetwork.where(id: network_ids).pluck(:id)
    UpDlPolicyNetwork.transaction do
      self.up_dl_policy_networks.delete_all
      network_ids_sanitized.each do |network_id|
        u = UpDlPolicyNetwork.new(up_dl_policy: self, up_dl_network_id: network_id)
        u.save
      end
    end
  end

  def users_attributes
    if self.id
      @users_attributes = self.users
    else
      @users_attributes
    end
  end

  def users_attributes=(user_ids)
    if self.is_for_all_users
      self.up_dl_policy_users.delete_all
    else
      user_ids_sanitized = User.active.where(id: user_ids).pluck(:id)
      UpDlPolicyUser.transaction do
        self.up_dl_policy_users.delete_all
        user_ids_sanitized.each do |user_id|
          u = UpDlPolicyUser.new(up_dl_policy: self, user_id: user_id)
          u.save
        end
      end
    end
  end

  # returns overall policy for given user, ip
  def self.overall_policy_for_user_with_ip(user, ip_str)
    # get policies associated to user for which ip_str does not match ip_list of the policy.
    ip_str_in_iplist_by_policy = user.overall_up_dl_policies.includes(:up_dl_networks).inject({}) { |h, (k, v)| h[k] = UpDlNetwork.is_ip_in_iplist?(ip_str, k.ip_list); h }.select{|k,v| #v == false
        if k.applicability_policy == "not_in_network_list"
          v == false
        else
          v == true
        end
      }.keys

    ip_str_in_iplist_by_policy_not_general = ip_str_in_iplist_by_policy.select{|p| !p.is_for_all_users}

    if ip_str_in_iplist_by_policy_not_general.any?
      ip_str_in_iplist_by_policy = ip_str_in_iplist_by_policy & ip_str_in_iplist_by_policy_not_general
    end
    
    # take the max among upload and download policies: Higher enum values = more restrictive
    overall_upload_policy = ip_str_in_iplist_by_policy.max_by{|a| UpDlPolicy.upload_policies[a.upload_policy]}.try(:upload_policy)
    overall_download_policy = ip_str_in_iplist_by_policy.max_by{|a| UpDlPolicy.download_policies[a.download_policy]}.try(:download_policy)

    overall_upload_policy ||= 0
    overall_download_policy ||= 0

    return UpDlPolicy.new(upload_policy: overall_upload_policy, download_policy: overall_download_policy, scope_policy: :global)
  end

  # returns the list of ips associated to up_dl_networks of the policy
  def ip_list
    return self.up_dl_networks.map(&:ip_list).flatten
  end
end