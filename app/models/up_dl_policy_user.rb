class UpDlPolicyUser < ActiveRecord::Base
  belongs_to :up_dl_policy
  belongs_to :user
end