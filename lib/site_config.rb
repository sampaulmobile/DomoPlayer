class SiteConfig
    SITEENV = defined?(Rails) ? Rails.env : ENV['RAILS_ENV'] || "test"

    private
    def self.settings(env)
        answer = YAML::load_file(File.join(Rails.root, 'config/siteconfig.yml'))[env]
        answer || { }
    end

    @@settings = settings('all').merge(settings(SITEENV))

    def self.method_missing key
        @@settings[key.to_s] if !@@settings.nil? && @@settings.include?(key.to_s)
    end 

    def self.load_env env
        @@settings = settings('all').merge(settings(env.to_s))
    end
end
