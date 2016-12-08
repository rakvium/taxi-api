# model for drivers, choose order for the execution, completes orders
class Driver < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # attr_accessor :phone

  devise :database_authenticatable, :recoverable,
          :rememberable, :trackable, :registerable

  def email_required?
    false
  end

  def login=(login)
    @login = login
  end

  def self.login
    @login || self.phone
  end

  def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(phone) = :value", { :value => login.downcase }]).first
  else
    if conditions[:phone].nil?
      where(conditions).first
    else
      where(phone: conditions[:phone]).first
    end
  end
end

  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:phone)
  #     where(conditions.to_h).where(["lower(phone) = :value", { :value => login.downcase }]).first
  #   elsif conditions.has_key?(:phone)
  #     where(conditions.to_h).first
  #   end
  # end
end
