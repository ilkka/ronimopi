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

@lounas_places = {}
LOUNAS_DATEFMT = '%Y%m%d'
@lounas_date = Time::now.localtime.strftime(LOUNAS_DATEFMT)

# open up Array and add count if not there
class Array
  def count
    return length
  end
end unless Array.method_defined? "count"

def handle_lounas(channel, nick, args)
  puts "Handling lunch for #{channel} where #{nick} requested #{args}"
  datenow = Time::now.localtime.strftime(LOUNAS_DATEFMT)
  if @lounas_date != datenow
    puts "Date changed, wiping places"
    @lounas_places.clear
    @lounas_date = datenow
  end
  if args.nil?
    puts "Sorting places"
    str = @lounas_places.keys.sort {|a,b| @lounas_places[b].count <=> @lounas_places[a].count }.inject('') do |s,p|
      s << "; " unless s.empty?
      s << "#{p}: #{@lounas_places[p].join(', ')}"
    end
    puts "Outputting: #{str}"
    msg channel, str
  else
    puts "Grokking args: #{args}"
    args.split(/,\s*/).each do |place|
      puts "Place: #{place}"
      if place =~ /^\^/
        place = place[1..-1]
        return if place.empty?
        puts "Deleting #{nick} from #{place}"
        if ! @lounas_places[place].nil?
          @lounas_places[place].delete(nick)
          if @lounas_places[place].empty? 
            @lounas_places.delete(place)
          end
        end
      else
        puts "Adding #{nick} to #{place} if not there already"
        if @lounas_places[place].nil?
          @lounas_places[place] = []
        end
        @lounas_places[place] << nick unless @lounas_places[place].include? nick
      end
    end
  end
end

