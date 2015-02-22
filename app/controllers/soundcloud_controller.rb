class SoundcloudController < ApplicationController

  def connect
      client = Soundcloud.new(:client_id => SiteConfig.SOUNDCLOUD_CLIENT_ID,
                              :client_secret => SiteConfig.SOUNDCLOUD_CLIENT_SECRET,
                              :redirect_uri => SiteConfig.SOUNDCLOUD_REDIRECT_URL)
      @url = client.authorize_url
  end

  def connected
      client = Soundcloud.new(:client_id => SiteConfig.SOUNDCLOUD_CLIENT_ID,
                              :client_secret => SiteConfig.SOUNDCLOUD_CLIENT_SECRET,
                              :redirect_uri => SiteConfig.SOUNDCLOUD_REDIRECT_URL)

      code = params[:code]
      token_hash = client.exchange_token(:code => code)

      user_client = Soundcloud.new(:access_token => token_hash.access_token)
      soundcloud_user = user_client.get('/me')

      u = User.find(1)
      u.soundcloud_access_token = token_hash.access_token
      u.soundcloud_refresh_token = token_hash.refresh_token
      # u.soundcloud_expires_in = token_hash.soundcloud_expires_in

      u.soundcloud_id = soundcloud_user.id
      u.soundcloud_username = soundcloud_user.username
      u.save

      @u_name = u.soundcloud_username
  end

end
