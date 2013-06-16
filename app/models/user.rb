class User < ActiveRecord::Base
  has_many :records
  attr_accessible :email, :password, :password_confirmation
  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create
  validates_confirmation_of :password, message: "must match confirmation"

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def current_time_zone
    r = self.records.limit(1).first
    r ? r.time_zone : ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
  end

end
