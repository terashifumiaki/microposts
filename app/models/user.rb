class User < ApplicationRecord
  
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  
  has_many :microposts
  
  # Relationship モデルは User モデル同士の関係だったので、 
  # User にもフォロー関係のコードを追加します。
  # has_many :microposts の後に4行追加しています。
  has_many :relationships
  
  # 『多対多の図』の左半分にいるUserの1人が自分自身だと仮定すると、
  # relationships という関係は 『多対多の図』の右半分にいる「自分がフォローしているUser」への参照 を表しています。
  has_many :followings, through: :relationships, source: :follow
 
  # 逆に『多対多の図』の右半分にいるUserの1人が自分自身だと仮定すると、
  # 下記の reverses_of_relationship は 「『多対多の図』の左半分にいるUserからフォローされている」という関係への参照（自分をフォローしているUserへの参照） を表しています。
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
 
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  # 中間テーブルを経由して相手の情報を取得できるようにするためには through を使用すると覚えておきましょう。
  
  def follow(other_user)
    # フォローしようとしている other_user が自分自身ではないかを検証
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
end
