#!/usr/bin/env ruby
require 'isaac/bot'

bot = Isaac::Bot.new do
  configure do |cfg|
    cfg.nick = "ronimopi"
    cfg.server = "irctr01.sasken.com"
    cfg.port = 6667
  end

  helpers do
    def handle_lounas(channel, args)
      msg channel, "Lounas: yks kaks"
    end
  end
  
  on :connect do
    join "#vzkhgk"
  end

  on :channel, /^[!](.+)/ do |cmdstr|
    parts = cmdstr.split(' ', 2)
    cmd = "handle_#{parts[0]}".to_sym
    args = parts[1]
    if respond_to? cmd
      send(cmd, channel, args)
    else
      msg channel, "I don't know that command"
    end
  end

  on :channel do
    # catchall, do nothing
  end
end

bot.start
