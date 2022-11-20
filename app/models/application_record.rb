class ApplicationRecord < ActiveRecord::Base
  include CableReady::Broadcaster
  delegate :render, to: :ApplicationController
  primary_abstract_class
end
