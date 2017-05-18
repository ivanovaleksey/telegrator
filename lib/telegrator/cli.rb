require 'thor'

module Telegrator
  class CLI < Thor
    register(
      Generators::Bot,
      'bot',
      'bot',
      'Generate a skeleton for creating a new bot'
    )
  end
end
