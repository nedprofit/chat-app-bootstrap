# Создание пользователей
user1 = User.create!(email: 'user1@example.com', password: 'password', password_confirmation: 'password')
user2 = User.create!(email: 'user2@example.com', password: 'password', password_confirmation: 'password')
user3 = User.create!(email: 'user3@example.com', password: 'password', password_confirmation: 'password')

# Создание общего чата
public_room = Room.create!(name: 'Общий чат', private: false)

# Создание приватных комнат
private_room1 = Room.create!(name: 'Приватный чат между user1 и user2', private: true)
private_room2 = Room.create!(name: 'Приватный чат между user2 и user3', private: true)

# Добавление участников в приватные комнаты
private_room1.participants << user1
private_room1.participants << user2

private_room2.participants << user2
private_room2.participants << user3
