require "colorize"

module Terminal
  def self.success(text)
    puts "✅ #{text}".colorize.green
  end

  def self.failure(text)
    puts "❎ #{text}".colorize.red
  end

  def self.skip(text)
    puts "❎ #{text}".colorize.dark_gray
  end

  def self.question(text, &block)
    print text.colorize.yellow
    while !(yield(gets))
      print text.colorize.yellow
    end
  end
end

Signal::INT.trap do
  Terminal.failure "Operation canceled by user"
  exit
end
