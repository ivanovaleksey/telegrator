module Telegrator
  module Generators
    class Bot < Base
      include Thor::Actions

      DATABASES = %w[postgresql mongodb].freeze

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

      class_option :skip_bundler, type: :boolean, default: false,
                                  desc: 'Skip Bundler'

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
        template 'gitignore.tt', '.gitignore'

        template 'env.tt', '.env.sample'
        template 'env.tt', '.env'

        template 'Gemfile.tt'
        template 'Rakefile.tt'
        template 'Capfile.tt' unless options[:skip_capistrano]
        template 'config.ru.tt' unless options[:skip_webhook]
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

      def create_services
        template 'app/services.rb'
        directory 'app/services'
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

        if options[:skip_capistrano]
          remove_file 'config/deploy/'
          remove_file 'config/deploy.rb'
        end
        remove_file 'config/initializers/sequel.rb' if mongodb?
      end

      # === db/ directory ===
      def create_db_dir
        return if mongodb?
        directory 'db'
      end

      # === lib/ directory ===
      def create_lib_dir
        directory 'lib'
        remove_file 'lib/tasks/db.rake' if mongodb?
      end

      # === log/ directory ===
      def create_log_dir
        empty_directory 'log'
        create_file 'log/.keep'
      end

      def init
        inside { run 'git init' }
        inside { run 'bundle install' } unless options[:skip_bundler]
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
