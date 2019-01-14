class CreateAdminForm
  include ActiveModel::Model

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validate :admin_does_not_exist

  attr_reader :email

  def initialize; end

  def submit(params)
    @email = params[:email]
    return false unless valid?
    Admin.create!(email: email)
  end

  private

  def admin_does_not_exist
    return if Admin.find_by(email: email).nil?
    errors.add(:email, 'already taken')
  end
end
