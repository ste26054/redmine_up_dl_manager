class UpDlNetwork < ActiveRecord::Base
  serialize :ip_list, Array

  attr_accessible :ip_list, :description

  validate :check_ip_list_valid

  def check_ip_list_valid
    unless ip_list.map{|str| UpDlNetwork.ip_valid?(str)}.any?
      errors.add(:ip_list, "Contains an invalid ip")
    end
  end

  def self.ip_valid?(str)
    return !(IPAddr.new(str) rescue nil).nil?
  end

  def self.is_ip_in_iplist?(ip_str, ip_list_str)
    list = ip_list_str.map{ |ip_s| IPAddr.new(ip_s) }
    compare_list = list.map { |ip_o| ip_o === ip_str }
    return compare_list.any?
  end

end