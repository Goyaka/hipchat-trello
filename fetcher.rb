require 'rest_client'
require 'yamler'
require 'json'
require 'pp'
require 'grove-rb'

class Fetcher
  attr_reader :config
  def initialize
    @config = Yamler.load('config.yml') 
  end

  def grove_push(message)
    grove = Grove.new(@config['grove']['channel_token'], :service => 'Trello', :icon_url => 'https://trello.com/favicon.ico')
    grove.post message
  end

  def signature
    "key=#{@config['trello']['app_id']}&token=#{@config['trello']['oauth_token']}"
  end

  def fetch_notifs
    url = "https://trello.com/1/members/me/notifications?#{self.signature}"
    begin
      JSON.parse (RestClient.get url)
    rescue RestClient::Unauthorized
      puts "Unauthorized. Please hit the URL below and save the response in config.yml (trello -> oauth_token) \n https://trello.com/1/authorize?key=#{@config['trello']['app_id']}&name=Markupwand&expiration=never&response_type=token&scope=read,write,account\n\n"

      throw "Unauthorized"
    end
  end

  def clear_notifs(notif)
    url = "https://trello.com/1/notifications/#{notif['id']}/unread?#{self.signature}"
    JSON.parse (RestClient.put url, "value=false")
  end

  def unread(notif)
    notif['unread']
  end

  def execute
    notifications = fetch_notifs
    notifications.reverse!

    Log.info "Notifications list = #{notifications}"
    notifications.each do |notification|
      if unread(notification)
        puts stringify(notification)
        grove_push stringify(notification)
        clear_notifs(notification)
      end
    end
  end

  def stringify(notification)
    type = notification['type']
    user = notification['memberCreator']['username']

    case type
    when 'changeCard' 
      if notification['data'].has_key? 'old' and  notification['data']['old'].has_key? 'closed'
        "#{user} closed card '#{notification['data']['card']['name']}' in '#{notification['data']['board']['name']}'"
      elsif notification['data'].has_key? 'listBefore' 
        "#{user} moved card '#{notification['data']['card']['name']}' from '#{notification['data']['listBefore']['name']}' to '#{notification['data']['listAfter']['name']}'"
      else 
        "#{user} changed card #{notification['data']['card']['name']}"
      end
    when 'createdCard'
      "#{user} created card '#{notification['data']['card']['name']}' into '#{notification['data']['list']['name']}' (#{notification['data']['board']['name']} board)"
    else
      "#{user} #{type} #{notification['data']['card']['name']}"
    end
  end
end
