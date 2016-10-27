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
      def overall_up_dl_policies
        up_dl_policies_statement = self.up_dl_policies.select(:id).to_sql
        for_all_users_statement = UpDlPolicy.where("id IN (#{up_dl_policies_statement}) OR is_for_all_users = 1")
      end
    end
  end
end

unless User.included_modules.include?(RedmineUpDlManager::Patches::UserPatch)
  User.send(:include, RedmineUpDlManager::Patches::UserPatch)
end