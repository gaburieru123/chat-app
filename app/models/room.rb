class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users , dependent: :destroy
  has_many :messages, dependent: :destroy
  #dependent: :destroyオプション」とは、親モデルが削除された時、それに紐付ている子モデルも一緒に削除
  #あくまでも「チャットルームに紐づいているユーザー情報を削除」なので、「メンバーの削除＝中間テーブルから該当するレコード削除」
  #一度登録したユーザー情報はusersテーブルに残ったまま
  validates :name, presence: true
end
