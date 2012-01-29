class UserObserver < ActiveRecord::Observer
  def after_create(user)
    json = get_user_profile(user)

    statistic = user.statistics.create(:uploaded => json['response']['stats']['uploaded'],
                                       :downloaded => json['response']['stats']['downloaded'],
                                       :posts => json['response']['community']['posts'],
                                       :uploads => json['response']['community']['uploaded'],
                                       :seeding => json['response']['community']['seeding'],
                                       :leeching => json['response']['community']['leeching'],
                                       :snatched => json['response']['community']['snatched'])
  end

  private
    def get_user_profile(user)
      agent = Mechanize.new
      agent.user_agent_alias = "Windows Mozilla"

      page = agent.get("#{APP_CONFIG['base_url']}/login.php")
      login_form = page.forms.last
      login_form.username = APP_CONFIG['username']
      login_form.password = APP_CONFIG['password']
      page = agent.submit login_form

      url = "#{APP_CONFIG['base_url']}/ajax.php?action=user&id=#{user.what_uid}&auth=#{APP_CONFIG['auth_key']}"
      data = agent.get(url).body

      JSON.parse(data)
    end
end
