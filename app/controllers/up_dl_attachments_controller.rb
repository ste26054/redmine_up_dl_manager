class UpDlAttachmentsController < ApplicationController
  layout 'admin'
  action :require_admin

  def index
    @up_dl_networks = UpDlNetwork.all
  end

  def network_new
    @up_dl_network = UpDlNetwork.new
  end

  def network_create
  end

  def network_edit
    @up_dl_network = UpDlNetwork.find(params[:id])
  end

  def network_update
  end

  def network_destroy
    @up_dl_network = UpDlNetwork.find(params[:id])
    @up_dl_network.destroy
    redirect_to up_dl_attachments_path
  end 

  private

  def up_dl_network_params
    params.require(:up_dl_network).permit(:description, :ip_list, :id)
  end

end