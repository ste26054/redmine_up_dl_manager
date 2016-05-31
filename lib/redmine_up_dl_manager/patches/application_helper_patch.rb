module RedmineUpDlManager
  module Patches
    module ApplicationHelperPatch
      def self.included(base)
        base.class_eval do
          
          def get_overall_user_policy
            @overall_user_policy = UpDlPolicy.overall_policy_for_user_with_ip(User.current, request.remote_ip)
            return @overall_user_policy
          end

          def other_formats_links_with_manager(&block)
            unless get_overall_user_policy.download_policy == "download_denied_except_inline_images"
              other_formats_links_without_manager(&block)
            end
          end

          alias_method_chain :other_formats_links, :manager
          
        end
      end
    end
  end
end

unless ApplicationHelper.included_modules.include?(RedmineUpDlManager::Patches::ApplicationHelperPatch)
  ApplicationHelper.send(:include, RedmineUpDlManager::Patches::ApplicationHelperPatch)
end