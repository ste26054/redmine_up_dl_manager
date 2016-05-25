module RedmineUpDlManager
  module Patches
    module AttachmentsControllerPatch
      def self.included(base)
        base.class_eval do
          # before_action :test
          

          def upload_with_manager
            Rails.logger.info "***** Calling upload_without_manager"
            render_403
            #upload_without_manager
          end

          alias_method_chain :upload, :manager
          # private

          # def test
          #   # byebug
          #   Rails.logger.info "***** REFERRER: #{request.referer}"
          # end
        end
      end
    end
  end
end

unless AttachmentsController.included_modules.include?(RedmineUpDlManager::Patches::AttachmentsControllerPatch)
  AttachmentsController.send(:include, RedmineUpDlManager::Patches::AttachmentsControllerPatch)
end