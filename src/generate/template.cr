require "tempfile"

module Generate
  module Template
    # For now, I disable the template system
    # Just use ERB
    def self.render(string, hash)
      string
    end
  end
end
