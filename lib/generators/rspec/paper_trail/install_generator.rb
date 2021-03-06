require 'rails/generators/active_record/migration'

module Rspec
  module PaperTrail
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)
      class_option :with_string_ids, type: :boolean, default: true, desc: 'versions.type_id as string (vs integer)'

      class_option :'skip-migrations', type: :boolean, default: false, desc: 'do not generate migrations'
      class_option :force, type: :boolean, default: false, desc: 'force generation migrations'

      desc 'Generates (but does not run) a migration to add versions table.'

      def generate_migration_file
        return if options.send(:'skip-migrations')
        migration_template 'migrations/create_versions.rb.erb', 'db/migrate/create_versions.rb'
        migration_template 'migrations/stringify_versions_item_id.rb', 'db/migrate/stringify_versions_item_id.rb' if use_string_ids? && connected? && migrated? && !has_integer_column?
      end

      desc 'Generates initialization files.'

      def generate_configuration_files
        copy_file 'features/versioning.rb', 'config/features/versioning.rb'
      end

      private

      def use_string_ids?
        options.with_string_ids?
      end

      def connected?
        ActiveRecord::Base.connected?
      end

      def migrated?
        ActiveRecord::Base.connection.table_exists? 'versions'
      end

      def has_integer_column?
        return false unless migrated?
        Version.columns.select { |obj| obj.name == 'item_id' }.first.try(:type) == :integer
      end
    end

  end
end
