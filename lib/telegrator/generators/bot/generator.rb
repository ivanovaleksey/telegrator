module Telegrator
  module Generators
    class Bot < Base
      include Thor::Actions

      DATABASES = %w[postgresql mongodb]

      # TODO: move to Base class
      def self.source_root
        File.expand_path('../templates', __FILE__)
      end

      def initialize(args = [], options = {}, config = {})
        config[:destination_root] ||= args.first
        super
      end

      class_option :database, type: :string, aliases: '-d', default: 'postgresql', enum: DATABASES,
                              desc: 'Preconfigure for selected database'

      class_option :skip_capistrano, type: :boolean, default: false,
                                     desc: 'Skip Capistrano'

      class_option :skip_keyboards, type: :boolean, default: false,
                                    desc: 'Skip keyboards'

      class_option :skip_webhook, type: :boolean, default: false,
                                  desc: 'Skip webhook'

      class_option :help, type: :boolean, aliases: '-h',
                          desc: 'Show this help message and quit'

      namespace 'bot'
      desc 'Bot generator description'

      argument :name

      def create_root_files
        template '.gitignore.tt'
        template '.env.tt', '.env.sample'
        template '.env.tt'
        template 'Gemfile.tt'
        template 'Rakefile.tt'
      end

      # === app/ directory ===
      def create_app_dir
        empty_directory 'app'
      end

      def create_commands
        template 'app/commands.rb'
        directory 'app/commands'
      end

      # TODO: inline keyboards

      def create_keyboards
        return if options[:skip_keyboards]
        template 'app/keyboards.rb'
        directory 'app/keyboards'
      end

      def create_models
        template 'app/models.rb'
        directory 'app/models'
      end

      def create_workers
        template 'app/workers.rb'
        directory 'app/workers'
      end

      # === bin/ directory ===
      def create_bin_dir
        directory 'bin', mode: :preserve
      end

      # === config/ directory ===
      def create_config_dir
        directory 'config'
        remove_file 'config/initializers/sequel.rb' if mongodb?
      end

      # === lib/ directory ===
      def create_lib_dir
        empty_directory 'lib/tasks'
      end

      # === log/ directory ===
      def create_log_dir
        empty_directory 'log'
        create_file 'log/.keep'
      end

      private

      DATABASES.each do |db|
        define_method "#{db}?" do
          options[:database] == db
        end
      end
    end
  end
end
