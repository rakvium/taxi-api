# model for drivers, choose order for the execution, completes orders
class Driver < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # attr_accessor :phone

  attr_writer :login

  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :registerable

  def email_required?
    false
  end

  def self.login
    @login || phone
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login == conditions.delete(:login)
      find_by(conditions).find_by(['lower(phone) = :value', { value: :login.downcase }])
    elsif conditions[:phone].nil? find_by(conditions)
    else
      find_by(phone: conditions[:phone])
    end
  end
end
