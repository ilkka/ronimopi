Robot Ninja Monkey Pirate
=========================

A minimalistic extensible IRC bot.

Uses Isaac for a framework. Isaac is (C) 2009 Harry Vangberg
<harry@vangberg.name> and can be found at
http://github.com/ichverstehe/isaac.

Author: Ilkka Laukkanen <ilkka.s.laukkanen@gmail.com>
Copyright (C) 2010 Ilkka Laukkanen

Installation
------------

This program requires the Isaac bot framework. To install it,
e.g. "gem install isaac".

Create the directory $HOME/.config/ronimopi and copy the provided
example config.yml file there. You will find it in the examples
directory. Customize the file to your liking.

There are also some plugins for handling !-commands in the
examples/commands.d directory. Create a commands.d directory under the
config directory you created above, and copy the plugins you would
like to use to that directory.

After you have done these things, just run it.

Writing more command handlers is easy-peasy: look at the
examples. Whatever you do in the plugins gets evaluated in the context
of Isaac's helpers, so take a look at Isaac's documentation too.

Usage
-----

When started, the bot will connect to the server you configured, read
all available plugins and join the channels you configured. Then it
will sit there.

Whenever a public message starts with an exclamation mark ("!"), the
bot will react by calling the associated handler helper: e.g. for a
public message "!foo bar baz", the bot will see if it has a helper
called "handle_foo" defined, and if it does, it will call that and
pass the channel name, the nick of the person who gave the command and
"bar baz" as arguments.

In short, if you want it to do anything, code.

License
-------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
