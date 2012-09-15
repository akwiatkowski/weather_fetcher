# Helps getting provider classes which should be executed because
# there might be updated weather
module WeatherFetcher
  class SchedulerHelper

    def self.recommended_providers(_wd, speed = 0.7)
      # all available
      all_providers_classes = ProviderList.providers(speed)

      # getting list providers to remove because there is now
      # new weather available
      providers_to_remove = _wd.select{|w| w.next_fetch_time > Time.now}.collect{|w| w.provider}.uniq

      # remove providers
      recommended = all_providers_classes.select{|k| ([k.provider_name] & providers_to_remove).size == 0}

      return recommended
    end

  end
end
