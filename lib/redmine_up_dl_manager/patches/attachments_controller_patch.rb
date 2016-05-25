module RedmineUpDlManager
  module Patches
    module AttachmentsControllerPatch
      def self.included(base)
        base.class_eval do
          before_action :get_overall_user_policy
          
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