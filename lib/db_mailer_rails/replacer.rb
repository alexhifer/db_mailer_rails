require 'mustache'

module DbMailerRails
  class Replacer
    attr_accessor :replace_hash

    # @param replace_hash [Hash]
    def initialize(replace_hash)
      self.replace_hash = replace_hash
    end

    # @param text [DbMailerRails::Base]
    # @return [String]
    def replace(text)
      Mustache.render(text, replace_hash)
    end
  end
end
