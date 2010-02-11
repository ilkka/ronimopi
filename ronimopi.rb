#!/usr/bin/env ruby
require 'isaac/bot'
CFGDIR=File::join(ENV['HOME'], '.config', 'ronimopi')

bot = Isaac::Bot.new do
  configure do |cfg|
    cfg.nick = "ronimopi"
    cfg.server = "irctr01.sasken.com"
    cfg.port = 6667
  end

  helpers do
    helperstr = ""
    Dir::glob(File::join(CFGDIR, 'commands.d', '*.rb')).each do |helper|
      File.new(helper).each_line do |line|
        helperstr << line
      end
    end
    eval helperstr
  end
  
  on :connect do
    join "#vzkhgk"
  end

  on :channel, /^[!](.+)/ do |cmdstr|
    parts = cmdstr.split(' ', 2)
    cmd = "handle_#{parts[0]}".to_sym
    args = parts[1]
    if respond_to? cmd
      send(cmd, channel, nick, args)
    else
      msg channel, "I don't know that command"
    end
  end

  on :channel do
    # catchall, do nothing
  end
end

bot.start
