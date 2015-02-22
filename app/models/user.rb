class User < ActiveRecord::Base

    def client
        @client ||= Soundcloud.new(:access_token => self.soundcloud_access_token)
        #throw something in here to refresh if necessary
    end

    def update_favorites
        SoundcloudWorker.perform_async('update_favorites', self.id)
    end

end
