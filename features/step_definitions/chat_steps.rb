Given(/^"([^"]*)" создает приватную комнату с "([^"]*)"$/) do |email1, email2|
  using_session(email1) do
    user1 = User.find_by(email: email1)
    user2 = User.find_by(email: email2)
    visit new_room_path(participant_id: user2.id)
    fill_in 'Enter room name', with: 'Приватная комната'
    click_button 'Create Room'
  end
end

When(/^"([^"]*)" отправляет сообщение "([^"]*)" в приватную комнату$/) do |email, message|
  using_session(email) do
    visit rooms_path
    click_link 'Приватная комната'
    fill_in 'Type your message here...', with: message
    click_button 'Send'
  end
end

Then(/^"([^"]*)" видит сообщение "([^"]*)" в приватной комнате$/) do |email, message|
  using_session(email) do
    visit rooms_path
    click_link 'Приватная комната'
    expect(page).to have_content(message)
  end
end

Given(/^Пользователь "([^"]*)" создает публичную комнату "([^"]*)"$/) do |email, room_name|
  using_session(email) do
    visit new_room_path
    fill_in 'Enter room name', with: room_name
    click_button 'Create Room'
  end
end

And(/^"([^"]*)" находится в комнате "([^"]*)"$/) do |email, room_name|
  using_session(email) do
    visit rooms_path
    click_link room_name
  end
end

When(/^"([^"]*)" отправляет сообщение "([^"]*)" в "([^"]*)"$/) do |email, message, room_name|
  using_session(email) do
    fill_in 'Type your message here...', with: message
    click_button 'Send'
  end
end

Then(/^"([^"]*)" и "([^"]*)" видят сообщение "([^"]*)" в "([^"]*)"$/) do |email1, email2, message, room_name|
  [email1, email2].each do |email|
    using_session(email) do
      visit current_path
      expect(page).to have_content(message)
    end
  end
end
