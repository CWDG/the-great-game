require 'bcrypt'

class Agent < ActiveRecord::Base
  belongs_to :agency, inverse_of: :agents

  attr_accessor :password
  attr_accessible :code_name, :email, :github, :password, :password_confirmation,
                  :agency, :agency_id

  validates :code_name, presence: true, uniqueness: true, length: {in: 3..20}
  validates :email, presence: true, uniqueness: true, length: {minimum: 6}
  validates :github, presence: true, uniqueness: true, allow_blank: false
  validates :password, presence: true, confirmation: true, on: :create
  validates :password_hash, presence: true, on: :save
  validates :password_salt, presence: true, on: :save
  validates :agency_id, presence: true

  before_create :encrypt_password

  def github_link
    "https://github.com/#{github}"
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
