class UpDlPolicyNetwork < ActiveRecord::Base
  belongs_to :up_dl_policy
  belongs_to :up_dl_network

  attr_accessible :up_dl_network_id, :up_dl_network, :up_dl_policy
end