class CreateYandexLanguages < ActiveRecord::Migration
  def change
    create_table :yandex_languages do |t|
      t.string :code
      t.string :language

      t.timestamps
    end
  end
end
