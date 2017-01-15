class UserProfile < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable
  self.table_name = "UserProfile"
  belongs_to :user

  accepts_nested_attributes_for :user

  before_validation :generate_user, on: :create

  validates :username, :user, :fieldVisibilityBitmap, presence: true

  def name
    "#{firstName} #{lastname}"
  end

  def role
    user.user_role.userRoleTitle
  end

  # Patching devise to use password instead of encrypted_password
  # And to use JustCode logic to validate password
  
  def valid_password?(password)
    # TODO Use JustCode logic to compare stored value
    read_attribute(:password) == password
  end

  def password=(new_password)
    # TODO Override and use password_digest with JustCode logic
    write_attribute(:password, new_password)
  end

  def password
    read_attribute(:password)
  end

  def clean_up_passwords
    self.password_confirmation = nil
  end

  def self.required_fields(klass)
    [:password] + klass.authentication_keys
  end

  def authenticatable_salt
    password[0,5] if password
  end

  def generate_user
    self.fieldVisibilityBitmap = 0
    
    build_user({
      isEmailConfirmed: false,
      isUserVisible: true,
      user_role_id_fk: UserRole.find_by(userRoleTitle: 'Regular').id,
      user_status_id_fk: UserStatus.find_by(userStatusTitle: 'Active').id
    })
  end
end
