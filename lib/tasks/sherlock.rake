require 'rubygems'
require 'json'
require 'net/http'

namespace :sherlock do
  desc 'Get stats for user'
  task :getjsonstats, :what_uid do |cmd, args|
    agent = Mechanize.new
    agent.user_agent_alias = "Windows Mozilla"

    page = agent.get("#{APP_CONFIG['base_url']}/login.php")
    login_form = page.forms.last
    login_form.username = APP_CONFIG['username']
    login_form.password = APP_CONFIG['password']
    page = agent.submit login_form
    url = "#{APP_CONFIG['base_url']}/ajax.php?action=user&id=#{args[:what_uid]}&auth=#{APP_CONFIG['auth_key']}"

    data = agent.get(url).body
    @result = JSON.parse(data)
  end

  task :newstats do
    Rake::Task[:environment].invoke
    what_uids = User.select(:what_uid)
    what_uids.each do |what|
      Rake::Task['sherlock:getjsonstats'].reenable
      Rake::Task['sherlock:getjsonstats'].invoke(what.what_uid)
      user = User.find_by_what_uid(what.what_uid)
      last_hours_stats = user.statistics.last
      statistic = user.statistics.create(:uploaded => @result['response']['stats']['uploaded'].to_i,
                                         :downloaded => @result['response']['stats']['downloaded'].to_i,
                                         :posts => @result['response']['community']['posts'],
                                         :uploads => @result['response']['community']['uploaded'].to_i,
                                         :seeding => @result['response']['community']['seeding'].to_i,
                                         :leeching => @result['response']['community']['leeching'].to_i,
                                         :snatched => @result['response']['community']['snatched'].to_i,
                                         :ratio => (@result['response']['stats']['uploaded'].to_f / @result['response']['stats']['downloaded'].to_f),
                                         :buffer => (@result['response']['stats']['uploaded'].to_i - @result['response']['stats']['downloaded'].to_i))
      statistic.create_hourly_statistic(:change_in_uploaded => (statistic.uploaded - last_hours_stats.uploaded),
                                        :change_in_downloaded => (statistic.downloaded - last_hours_stats.downloaded),
                                        :change_in_uploads => (statistic.uploads - last_hours_stats.uploads),
                                        :change_in_snatched => (statistic.snatched - last_hours_stats.snatched),
                                        :change_in_posts => (statistic.posts - last_hours_stats.posts),
                                        :change_in_seeding => (statistic.seeding - last_hours_stats.seeding),
                                        :change_in_leeching => (statistic.leeching - last_hours_stats.leeching),
                                        :change_in_buffer => (statistic.buffer - last_hours_stats.buffer),
                                        :change_in_ratio => (statistic.ratio - last_hours_stats.ratio))
    end
  end
end

