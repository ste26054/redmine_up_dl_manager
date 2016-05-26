class UpDlPolicyUser < ActiveRecord::Base
  belongs_to :up_dl_policy
  belongs_to :user

  attr_accessible :user_id, :up_dl_policy_id, :up_dl_policy
end