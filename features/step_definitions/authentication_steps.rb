Given(/^Существует пользователь с email "(.*?)" и паролем "(.*?)"$/) do |email, password|
  FactoryBot.create(:user, email: email, password: password)
end

Given(/^Пользователь с email "(.*?)" вошел в приложение$/) do |email|
  using_session(email) do
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: 'password' # Используйте фактический пароль, если он отличается
    click_button 'Log in'
  end
end