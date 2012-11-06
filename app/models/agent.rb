require 'bcrypt'

class Agent < ActiveRecord::Base
  belongs_to :agency, inverse_of: :agents

  attr_accessible :code_name, :email, :github, :agency, :agency_id

  validates :code_name, presence: true, uniqueness: true, length: {in: 3..20}
  validates :email, presence: true, uniqueness: true, length: {minimum: 6}
  validates :github, presence: true, uniqueness: true, allow_blank: false
  validates :agency_id, presence: true


  def github_link
    "https://github.com/#{github}"
  end

end
