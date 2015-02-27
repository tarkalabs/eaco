module Eaco
  module Cucumber
    module ActiveRecord

      # @!method schema
      #
      # Defines the database schema for the {Eaco::Cucumber::World} scenario.
      #
      # @see Eaco::Cucumber::World
      #
      ::ActiveRecord::Schema.define(version: '2015022301') do
        # Resource
        create_table 'documents', force: true do |t|
          t.string :name
          t.column :acl, :jsonb
        end

        # Actor
        create_table 'users', force: true do |t|
          t.string :name
        end

        # Designator source
        create_table 'departments', force: true do |t|
          t.string :abbr
        end

        # Designator source
        create_table 'positions', force: true do |t|
          t.string :job_title

          t.references :user
          t.references :department
        end
      end

    end
  end
end
