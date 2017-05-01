require 'thor'

module Telegrator
  class CLI < Thor
    # register(class_name, subcommand_alias, usage_list_string, description_string)
    register(Generators::Bot, 'bot', 'bot', 'Generate a skeleton for creating a new bot')
  end
end
