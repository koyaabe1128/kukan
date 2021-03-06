class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 255 }
  
  #アソシエーション
  has_many :events, dependent: :destroy
  
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :likes, dependent: :destroy
  has_many :like_events, through: :likes, source: :event
  
  #パスワードを暗号化して保存する
  has_secure_password
  
  #モデルとの関連付け　mount_uploader :carrierwave用に作ったカラム名, carrierwaveの設定ファイルのクラス名
  mount_uploader :image, ImageUploader
  
  #ジャンルに整数を割り当てる
  enum genre: { HIPHOP:0, HOUSE:1, LOCK:2, POP:3, JAZZ:4, PUNKING:5, BREAK:6, FREESTYLE:7, その他:8 }
  #都道府県に整数を割り当てる
  enum prefecture: {
     北海道:0,青森県:1,岩手県:2,宮城県:3,秋田県:4,山形県:5,福島県:6,
     茨城県:7,栃木県:8,群馬県:9,埼玉県:10,千葉県:11,東京都:12,神奈川県:13,
     新潟県:14,富山県:15,石川県:16,福井県:17,山梨県:18,長野県:19,
     岐阜県:20,静岡県:21,愛知県:22,三重県:23,
     滋賀県:24,京都府:25,大阪府:26,兵庫県:27,奈良県:28,和歌山県:29,
     鳥取県:30,島根県:31,岡山県:32,広島県:33,山口県:34,
     徳島県:35,香川県:36,愛媛県:37,高知県:38,
     福岡県:39,佐賀県:40,長崎県:41,熊本県:42,大分県:43,宮崎県:44,鹿児島県:45, 
     沖縄県:46
   }
  
  #フォローしているかを確認するメソッド
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  #フォローするときのメソッド
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  #フォローを外すときのメソッド
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  #いいねしているかを確認するメソッド
  def like?(other_event)
    self.like_events.include?(other_event)
  end
end
