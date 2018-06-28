class CreateHeadings < ActiveRecord::Migration[5.1]
  def change
    create_table :headings do |t|
      t.integer :member_id
      t.text :header_text

      t.timestamps
    end
  end
end
