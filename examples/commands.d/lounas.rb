# lunch plugin for Ronimopi
#
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
@places = {}
def handle_lounas(channel, nick, args)
  puts "Handling lunch for #{channel} where #{nick} requested #{args}"
  if args.nil?
    puts "Sorting places"
    str = @places.keys.sort {|a,b| @places[b].count <=> @places[a].count }.inject('') do |s,p|
      s << "; " unless s.empty?
      s << "#{p}: #{@places[p].join(', ')}"
    end
    puts "Outputting: #{str}"
    msg channel, str
  else
    puts "Grokking args: #{args}"
    args.split(/,\s*/).each do |place|
      puts "Place: #{place}"
      if place =~ /^\^/
        place = place[1..-1]
        puts "Deleting #{nick} from #{place}"
        @places[place].delete(nick) unless !@places.key?(place)
        @places.delete(place) if @places[place].empty?
      else
        puts "Adding #{nick} to #{place} if not there already"
        @places[place] = [] unless @places.key?(place)
        @places[place] << nick unless @places[place].include? nick
      end
    end
  end
end

