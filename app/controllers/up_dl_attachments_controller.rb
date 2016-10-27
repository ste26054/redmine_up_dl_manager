class UpDlAttachmentsController < ApplicationController
  layout 'admin'
  action :require_admin

  before_action :retrieve_up_dl_network, only: [:network_edit, :network_update, :network_destroy]
  before_action :retrieve_up_dl_policy, only: [:edit, :update, :destroy]

  def index
    @up_dl_networks = UpDlNetwork.all
    @up_dl_policies = UpDlPolicy.all
  end

  def new
    @up_dl_policy = UpDlPolicy.new
  end

  def create
    @up_dl_policy = UpDlPolicy.new(up_dl_policies_params)
    if @up_dl_policy.save
      redirect_to up_dl_attachments_path
    else
      render :new
    end
  end

  def edit
  end  

  def update
    if @up_dl_policy.update(up_dl_policies_params)
      redirect_to up_dl_attachments_path
    else
      render :edit
    end
  end

  def destroy
    @up_dl_policy.destroy
    redirect_to up_dl_attachments_path
  end

  def network_new
    @up_dl_network = UpDlNetwork.new
  end

  def network_create
    @up_dl_network = UpDlNetwork.new(up_dl_network_params)
    if @up_dl_network.save
      redirect_to up_dl_attachments_path
    else
      render :network_new
    end
  end

  def network_edit
  end

  def network_update
    if @up_dl_network.update(up_dl_network_params)
      redirect_to up_dl_attachments_path
    else
      render :network_edit
    end
  end

  def network_destroy
    @up_dl_network.destroy
    redirect_to up_dl_attachments_path
  end 

  private

  def retrieve_up_dl_network
    @up_dl_network ||= UpDlNetwork.find(params[:id])
  end

  def retrieve_up_dl_policy
    @up_dl_policy ||= UpDlPolicy.find(params[:id])
  end

  def up_dl_network_params
    params.require(:up_dl_network).permit(:description, :ip_list_str, :id)
  end

  def up_dl_policies_params
    params.require(:up_dl_policy).permit(:description, :upload_policy, :download_policy, :scope_policy, :applicability_policy, :is_for_all_users, up_dl_networks_attributes: [], users_attributes: [])
  end

end