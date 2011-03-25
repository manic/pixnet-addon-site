# GooglePshb, modify from SupperfeedrPshb
require 'httparty'

class GooglePshb
  include HTTParty
  attr_accessor :hub, :callback_root
  base_uri nil

  def initialize(callback_root, hub = "http://superfeedr.com/hubbub")
    self.class.base_uri hub
    @callback_root = callback_root
  end

  def create_and_send_request(type, mode_options)
    options = { :body => { 'hub.mode' => type, 'hub.verify' => "sync" } }
    options[:body].merge!(mode_options)
    puts options.inspect
    self.class.post('/subscribe', options)
  end

  def subscribe(callback, topic, token)
    options = {'hub.callback' => @callback_root + callback, 'hub.topic' => topic, 'hub.verify_token' => token}
    create_and_send_request("subscribe", options)
  end

  def unsubscribe(callback, topic, token)
    options = {'hub.callback' => @callback_root + callback, 'hub.topic' => topic, 'hub.verify_token' => token}
    create_and_send_request("unsubscribe", options)
  end

end
