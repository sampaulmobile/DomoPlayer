class AddDownloadedStreamedToTracks < ActiveRecord::Migration
    def change
        add_column :tracks, :downloaded, :boolean, default: false
        add_column :tracks, :streamed, :boolean, default: false
    end
end
