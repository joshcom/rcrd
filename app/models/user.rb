class User < ActiveRecord::Base
  has_many :records
  attr_accessible :email, :password, :password_confirmation, :time_zone
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
    r ? r.time_zone : self.default_time_zone
  end

  def default_time_zone
    ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
  end

  def get_trending_cats
    cat_freqs = self.get_list_of_cat_frequencies
    cat_freqs = cat_freqs.sort_by {|k,v| -v}
    cat_freqs.collect! {|f| f.first }
    return cat_freqs
  end

  def get_list_of_cat_frequencies
    cat_list = {}
    self.records.each do |record|
      record.cats_from_raw_without_mags.each do |cat|
        cat_list[cat] = 0 if !cat_list[cat]
        cat_list[cat] += 1
      end 
    end
    return cat_list
  end


end
