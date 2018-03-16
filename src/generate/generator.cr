module Generate
  class Generator
    property target_directory : String = "."
    property variables = {} of String => String

    def initialize
    end

    def []=(key, value)
      @variables.[]=(key, value)
    end

    def [](key, value)
      @variables.[](key, value)
    end

    def []?(key, value)
      @variables.[]?(key, value)
    end

    # Generate a file from a string
    def file(file_path : String, content : String)
      file_path = abs_path(file_path)

      output = Template.render(content, @variables)

      if File.exists?(file_path)
        old_file_content = File.read(file_path)

        if old_file_content != output
          Terminal.question("File `#{file_path}` already exists. [R]eplace, [S]kip or [D]iff ?") do |answer|
            case answer
            when /R(eplace)?/i
              Terminal.success "Replacing #{file_path}..."
              File.write(file_path, output)
            when /S(kip)?/i
              Terminal.skip "Skipping `#{file_path}`"
            when /D(iff)?/i
              Diff.diff(output, File.read(file_path))
              false
              next
            when /Q(uit)?/i
              Terminal.failure "Operation canceled by user"
              exit
            else
              false
              next
            end

            true
          end
        end
      else
        Terminal.success "Writing #{file_path}..."
        File.write(file_path, output)
      end
    end

    # def file(file_path : String, ecr : String)
    # end

    def copy_file(from : String, to : String)
    end

    def mkdir_if_needed(path : String)
      path = abs_path(path)
      unless Dir.exists? path
        Terminal.success "Create #{path}..."
        Dir.mkdir_p path
      else
        Terminal.skip "#{path} already existing, Skipping"
      end
    end

    def abs_path(path)
      File.expand_path(path, @target_directory)
    end

    def in_directory(path : String, &block)
      temp = @target_directory

      begin
        @target_directory = abs_path(path)

        unless Dir.exists?(@target_directory)
          mkdir_if_needed(@target_directory)
        end

        yield
      ensure
        @target_directory = temp
      end
    end
  end
end
