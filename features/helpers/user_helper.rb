module UserHelper
  def sign_in(attributes = nil)
    visit root_path
    attributes ||= default_attributes
    user = create_user(attributes)
    fill_in 'session_email', with: attributes[:email]
    fill_in 'session_password', with: attributes[:password]
    click_button('Sign in')
    user
  end

  def create_user(attributes = {})
    User.find_by(email: attributes[:email]) || FactoryGirl.create(:user, attributes)
  end

  def sign_out
    click_link 'Sign out'
  end

  private

  def default_attributes
    default_user = FactoryGirl.build(:user)
    { email: default_user.email, password: default_user.password }
  end
end

World(UserHelper)
