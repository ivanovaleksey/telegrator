module Telegrator
  module Generators
    class Base < Thor::Group
      class << self
        def dispatch(command, given_args, given_opts, config)
          if command.nil? && given_args.empty? && given_opts.empty?
            given_args << '--help'
            given_opts << '--help'
          end
          super
        end
      end
    end
  end
end
