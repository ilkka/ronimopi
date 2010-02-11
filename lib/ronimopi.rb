# Ronimopi, a simple extensible IRC bot
# Copyright (C) 2010 Ilkka Laukkanen <ilkka.s.laukkanen@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'isaac/bot'
CFGDIR=File::join(ENV['HOME'], '.config', 'ronimopi')

bot = Isaac::Bot.new do
  @channels = []
  
  configure do |cfg|
    File::open(File::join(CFGDIR, 'config.yml')) do |yf|
      YAML.each_document(yf) do |ydoc|
        cfg.nick = ydoc["nick"] if ydoc.key? "nick"
        cfg.server = ydoc["server"] if ydoc.key? "server"
        cfg.port = ydoc["port"] if ydoc.key? "port"
        @channels += ydoc["channels"] if ydoc.key? "channels"
      end
    end
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
    @channels.each do |ch|
      puts "Joining #{ch}"
      join ch
    end
  end

  on :channel, /^[!](.+)/ do |cmdstr|
    parts = cmdstr.split(/\s+/, 2)
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
