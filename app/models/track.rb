class Track < ActiveRecord::Base



    def self.process_track(sc_track)
        puts "Processing track #{sc_track.title}"

        soundcloud_id = sc_track.id
        t = Track.where(soundcloud_id: sc_track.id).first
        if !t
            t = Track.create({ soundcloud_id: soundcloud_id,
                               soundcloud_user_id: sc_track.user_id,
                               soundcloud_created_at: sc_track.created_at
            })
        end
        opts = { download_url: sc_track.download_url }
        ['title', 'uri', 'sharing', 
         'description', 'duration', 'genre', 
         'downloadable', 'streamable',
         'comment_count', 'download_count', 
         'playback_count', 'favoritings_count'].each do |c|
             opts[c.to_sym] = sc_track.fetch(c)
        end

        t.update_attributes(opts)
        if t.downloadable && !t.downloaded
            SoundcloudWorker.perform_async('download', t.id, t.title)
        end
    end

end
