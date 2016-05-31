module RedmineUpDlManager
  module Patches
    module AttachmentsHelperPatch
      def self.included(base)
        base.class_eval do
          
          def link_to_attachments_with_manager(container, options = {})
            if get_overall_user_policy.download_policy == "download_denied_except_inline_images"
              return "<hr><p><strong>#{l(:download_forbidden_message)}</strong></p>".html_safe
            else
              link_to_attachments_without_manager(container, options = {})
            end
          end
          
          alias_method_chain :link_to_attachments, :manager
        end
      end
    end
  end
end

unless AttachmentsHelper.included_modules.include?(RedmineUpDlManager::Patches::AttachmentsHelperPatch)
  AttachmentsHelper.send(:include, RedmineUpDlManager::Patches::AttachmentsHelperPatch)
end