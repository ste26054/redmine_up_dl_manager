class UpDlAttachmentsController < ApplicationController
  layout 'admin'
  action :require_admin

  def index
  end
end