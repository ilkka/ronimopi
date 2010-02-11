#!/usr/bin/env ruby
require 'isaac/bot'

bot = Isaac::Bot.new do
  configure do |cfg|
    cfg.nick = "ronimopi"
    cfg.server = "irctr01.sasken.com"
    cfg.port = 6667
  end

  on :connect do
    join "#vzkhgk"
  end
  
  on :channel do
  end
end

bot.start
