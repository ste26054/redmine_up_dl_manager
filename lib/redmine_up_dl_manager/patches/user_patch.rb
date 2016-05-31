module RedmineUpDlManager
  module Patches
    module  UserPatch
      def self.included(base)

        base.send(:include, UserInstanceMethods)

        base.class_eval do
          unloadable
          has_many :up_dl_policy_users, dependent: :destroy
          has_many :up_dl_policies, through: :up_dl_policy_users
        end

      end
    end

    module UserInstanceMethods
      
    end
  end
end

unless User.included_modules.include?(RedmineUpDlManager::Patches::UserPatch)
  User.send(:include, RedmineUpDlManager::Patches::UserPatch)
end