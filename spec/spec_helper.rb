require 'rubygems'
require 'bundler/setup'

require 'rails'
require 'active_record'
require 'paper_trail'
require 'rspec/paper_trail'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :models do |t|
    t.string :name
    t.string :color
  end
  create_table :versions do |t|
    t.string   :item_type, :null => false
    t.integer  :item_id,   :null => false
    t.string   :event,     :null => false
    t.string   :whodunnit
    t.text     :object
    t.datetime :created_at
  end
end

class Model < ActiveRecord::Base
  has_paper_trail
  attr_accessible :name, :color
end
