module RedmineUpDlManager
  module Patches
    module AttachmentsHelperPatch
      def self.included(base)
        base.class_eval do
          
          def test
            @test_val = "<p>TEST</p>".html_safe
          end
          
        end
      end
    end
  end
end

unless AttachmentsHelper.included_modules.include?(RedmineUpDlManager::Patches::AttachmentsHelperPatch)
  AttachmentsHelper.send(:include, RedmineUpDlManager::Patches::AttachmentsHelperPatch)
end