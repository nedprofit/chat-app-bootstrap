class Room < ApplicationRecord
  has_many :messages

  validates :name, presence: true

  has_many :room_participations
  has_many :participants, through: :room_participations, source: :user

  def private_room?
    private
  end
end
