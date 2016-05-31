class UpDlPolicyUser < ActiveRecord::Base
  belongs_to :up_dl_policy
  belongs_to :user

  attr_accessible :user_id, :user, :up_dl_policy
end