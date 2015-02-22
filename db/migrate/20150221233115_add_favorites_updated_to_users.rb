class AddFavoritesUpdatedToUsers < ActiveRecord::Migration
    def change
        add_column :users, :favorites_updated_at, :datetime, default: DateTime.new(1969, 1, 1)
    end
end
