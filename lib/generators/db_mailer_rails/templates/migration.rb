class Create<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= table_name %> do |t|
      t.string :db_mailer_class, limit: 64, null: false
      t.string :subject, limit: 80, null: false
      t.string :from, limit: 64, null: false
      t.string :to, limit: 64, null: false
      t.text :body, null: false

      t.timestamps null: false
    end

    add_index :<%= table_name %>, :db_mailer_class, unique: true
  end
end
