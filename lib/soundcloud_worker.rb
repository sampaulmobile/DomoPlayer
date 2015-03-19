class SoundcloudWorker
    include Sidekiq::Worker

    PAGE_SIZE = 200
    # SONG_DIR = '~/Downloads/songs'
    SONG_DIR = '~/Music/iTunes/iTunes\ Media/Automatically*'


    def self.update_all_favorites
        users = User.order('favorites_updated_at DESC').first(10)
        users.each { |u| u.update_favorites }
    end

    def self.update_favorites(u_id)
        u = User.find(u_id)
        c = u.client

        res = c.get('/me/favorites',
                    :order => 'created_at', 
                    :limit => PAGE_SIZE,
                    :linked_partitioning => 1)
        res.collection.each do |track|
            Track.process_track(track)
        end

        while res.next_href
            res = c.get(res.next_href)
            res.collection.each do |track|
                Track.process_track(track)
            end
        end

        u.update_attribute(:favorites_updated_at, Time.now)
    end

    def self.download_track(id, title)
        t = Track.find(id)
        return if t.downloaded

        url = "#{t.download_url}?client_id=#{SiteConfig.SOUNDCLOUD_CLIENT_ID}"

        # file_path = "songs/'#{user.soundcloud_username}'/'#{filename}.mp3'"
        # `mkdir -p songs/#{user.soundcloud_username}`

        filename = title.gsub(/[\x00\/\\:\*\?\"<>\|]/, '_')
        # mkdir_cmd = "mkdir -p #{SONG_DIR}"
        # `#{mkdir_cmd}`

        file_path = "#{SONG_DIR}/'#{filename}.mp3'"
        cmd = "curl #{url} -L > #{file_path}"
        `#{cmd}`

        t.update_attribute(:downloaded, true)
    end

    def perform(task, *args)
        case task
        when 'download'
            SoundcloudWorker.download_track(*args)
        when 'update_favorites'
            SoundcloudWorker.update_favorites(*args)
        end
    end

end
