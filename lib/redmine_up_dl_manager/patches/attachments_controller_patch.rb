module RedmineUpDlManager
  module Patches
    module AttachmentsControllerPatch
      def self.included(base)
        base.class_eval do
          before_action :get_overall_user_policy

          def download_with_manager
            if get_overall_user_policy.download_policy == "download_denied_except_inline_images" && !@attachment.image?
              flash[:error] = l(:download_forbidden_message)
              if request.referer
                redirect_to :back
              elsif @attachment.container
                redirect_to @attachment.container
              else
                redirect_to home_url
              end
            else
              download_without_manager
            end
          end

          def upload_with_manager
            if get_overall_user_policy.upload_policy == "upload_denied"
              flash[:error] = l(:upload_forbidden_message)
              if request.referer
                redirect_to :back
              elsif @attachment.container
                redirect_to @attachment.container
              else
                redirect_to home_url
              end
            else
              upload_without_manager
            end
          end

          alias_method_chain :upload, :manager
          alias_method_chain :download, :manager
          
          private

          def get_overall_user_policy
            @overall_user_policy = UpDlPolicy.overall_policy_for_user_with_ip(User.current, request.remote_ip)
          end

        end
      end
    end
  end
end

unless AttachmentsController.included_modules.include?(RedmineUpDlManager::Patches::AttachmentsControllerPatch)
  AttachmentsController.send(:include, RedmineUpDlManager::Patches::AttachmentsControllerPatch)
end