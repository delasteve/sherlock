require 'rubygems'
require 'active_record/base'
require 'json'
require 'net/http'

namespace :sherlock do
  desc 'Update all users statistics for the hour'
  task :hourly_update => :environment do
    what_uids = User.select(:what_uid)
    what_uids.each do |what|
      Rake::Task['sherlock:getjsonstats'].reenable
      Rake::Task['sherlock:getjsonstats'].invoke(what.what_uid)
      user = User.find_by_what_uid(what.what_uid)

      statistic = user.statistics.create(:uploaded => @result['response']['stats']['uploaded'],
                                         :downloaded => @result['response']['stats']['downloaded'],
                                         :posts => @result['response']['community']['posts'],
                                         :uploads => @result['response']['community']['uploaded'],
                                         :seeding => @result['response']['community']['seeding'],
                                         :leeching => @result['response']['community']['leeching'],
                                         :snatched => @result['response']['community']['snatched'])
    end
  end

  desc 'Get json statistics for user'
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
end

