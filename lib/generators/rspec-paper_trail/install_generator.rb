require 'rails/generators/active_record/migration'

module Rspec::PaperTrail
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)
    class_option :with_string_ids, type: :boolean, default: true, desc: 'versions.type_id as string (vs integer)'

    # paperclip-3.3.x seems to require this
    # paperclip-3.4.x seems to have broken this
    class_option :with_revision_in_filename, type: :boolean, default: false, desc: 'filename on system to include version-number'

    class_option :'skip-migrations', type: :boolean, default: false, desc: 'do not generate migrations'
    class_option :force, type: :boolean, default: false, desc: 'force generation migrations'

    desc 'Generates (but does not run) a migration to add attachments and versions tables.'

    def generate_migration_file
      return if options.send(:'skip-migrations')
      migration_template 'migrations/create_versions.rb', 'db/migrate/create_versions.rb'
      migration_template 'migrations/stringify_versions_item_id.rb', 'db/migrate/stringify_versions_item_id.rb' if use_string_ids? && (!migrated? || has_integer_column?)
    end

    desc 'Generates initialization files.'

    def generate_configuration_files
      copy_file 'features/versioning.rb', 'config/features/versioning.rb'
    end

    desc 'Augments spec/spec_helper.rb adding paperclip and rspec-extensions'

    def augment_spec_helper
      [ 'config.include RspecPapertrailExtensions' ].each do |line|
        insert_into_file 'spec/spec_helper.rb', "  #{line}\n", after: "RSpec.configure do |config|\n"
      end
      ["require \'paperclip/matchers\'"].each do |line|
        insert_into_file 'spec/spec_helper.rb', "#{line}\n", before: "RSpec.configure do |config|\n"
      end
    end
  private
    def use_versioned_filename?
      options.with_revision_in_filename?
    end
    def use_string_ids?
      options.with_string_ids?
    end
    def migrated?
      return true if ActiveRecord::Base.connection.table_exists? 'versions'
    end
    def has_integer_column?
      return false unless migrated?
      Version.columns.select{|obj| obj.name == 'item_id'}.first.try(:type) == :integer
    end
  end

end
