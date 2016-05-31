module UpDlAttachmentsHelper
  def upload_policies_options_for_select
    UpDlPolicy.upload_policies.keys.to_a.map{|a| [a.humanize, a]}
  end

  def download_policies_options_for_select
    UpDlPolicy.download_policies.keys.to_a.map{|a| [a.humanize, a]}
  end

  def scope_policies_options_for_select
    UpDlPolicy.scope_policies.keys.to_a.map{|a| [a.humanize, a]}
  end  

  def applicability_policies_options_for_select
    UpDlPolicy.applicability_policies.keys.to_a.map{|a| [a.humanize, a]}
  end

  def active_users_options_for_select
    User.all.active.map{|u| [u.name, u.id]}.sort_by{|u| u[0]}
  end

end