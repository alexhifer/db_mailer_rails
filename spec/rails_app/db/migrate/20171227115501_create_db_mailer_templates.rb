superclass = ActiveRecord::Migration
# TODO: Inherit from the 5.0 Migration class directly when we drop support for Rails 4.
superclass = ActiveRecord::Migration[5.0] if superclass.respond_to?(:[])

class CreateDbMailerTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :db_mailer_templates do |t|
      t.string :db_mailer_class, limit: 64, null: false
      t.string :subject, limit: 80, null: false
      t.string :from, limit: 64, null: false
      t.string :to, limit: 64, null: false
      t.text :body, null: false

      t.timestamps null: false
    end

    add_index :db_mailer_templates, :db_mailer_class, unique: true
  end
end
