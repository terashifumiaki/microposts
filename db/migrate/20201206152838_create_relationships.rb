class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      
 # t.references という記述は別のテーブルを参照させるという意味
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users }
# 外部キーとしてusersテーブルを参照するという指定
      t.timestamps
      
      t.index [:user_id, :follow_id], unique: true
      # これは user_id と follow_id のペアで重複するものが保存されないようにするデータベースの設定
    end
  end
end
