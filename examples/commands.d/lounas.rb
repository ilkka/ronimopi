# lunch plugin
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

