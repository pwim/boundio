require "json"
require "rest-client"
require "thor"
require "active_support/core_ext/string/inflections"

module Boundio
  %w[audio_file application call exception resource tel_status version].each do |s|
    autoload s.camelize.to_sym, "boundio/#{s}"
  end
end
