class AddDownloadUrlToTracks < ActiveRecord::Migration
    def change
        add_column :tracks, :download_url, :string
    end
end
