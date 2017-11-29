require 'thor'

module Telegrator
  class CLI < Thor
    desc 'version', 'Print version info'
    def version
      say "Telegrator #{Telegrator::VERSION}"
    end
    map %w[-v --version] => :version

    register(
      Generators::Bot,
      'bot',
      'bot',
      'Generate a skeleton for creating a new bot'
    )
  end
end
