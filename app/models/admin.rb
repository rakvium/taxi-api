# model for admins, this model can CRUD for all models in the system
class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  def email_required?
    true
  end

  def self.login
    @login || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login == conditions.delete(:login)
      find_by(conditions).find_by(['lower(phone) = :value', { value: :login.downcase }])
    elsif conditions[:email].nil? find_by(conditions)
    else
      find_by(email: conditions[:email])
    end
  end
end
