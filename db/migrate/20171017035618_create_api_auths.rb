class CreateApiAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :api_auths do |t|
      t.string :name
      t.string :auth

      t.timestamps
    end
  end
end
