require "tempfile"

module Generate
  module Template
    def self.render(string, hash)
      string.gsub(/(^|[^\$])(\$([A-Z_a-z0-9\.]+))/) do |str, match|
        if hash[match[3]]?
          match[1] + hash[match[3]]
        else
          ""
        end
      end
    end
  end
end
