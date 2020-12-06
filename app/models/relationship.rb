class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
# 命名規則を変更している :follow について補足設定をしなければいけません。
# これにより follow が Follow という存在しないクラスを参照することを防ぎ、User クラスを参照するものだと明示

end
