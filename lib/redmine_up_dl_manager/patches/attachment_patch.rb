module RedmineUpDlManager
  module Patches
    module  AttachmentPatch
      def self.included(base)

        base.send(:include, AttachmentInstanceMethods)

        base.class_eval do
          unloadable
          
        end

      end
    end

    module AttachmentInstanceMethods
      def is_actually_image?
        unless RUBY_PLATFORM.include? 'mswin32'
          return `file --mime -br "#{self.diskfile}"`.strip.split(';').first.split('/').first == "image"
        else
          return self.image?
        end
      end
    end
  end
end

unless Attachment.included_modules.include?(RedmineUpDlManager::Patches::AttachmentPatch)
  Attachment.send(:include, RedmineUpDlManager::Patches::AttachmentPatch)
end