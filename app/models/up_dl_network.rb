class UpDlNetwork < ActiveRecord::Base
  serialize :ip_list, Array

  attr_accessible :ip_list, :description

  validate :check_ip_list_valid

  def check_ip_list_valid
    if (ip_list.map{|str| ip_valid?(str)} & [false]).size > 0
      errors.add(:ip_list, "Contains an invalid ip")
    end
  end

  private

  def ip_valid?(str)
    return !(IPAddr.new(str) rescue nil).nil?
  end
end