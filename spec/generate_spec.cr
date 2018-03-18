require "spec"
require "../src/generate.cr"

describe "Generate.cb" do
  it "can generate from template" do
    `rm -r ./generated`

    generator = Generate::Generator.new
    generator.target_directory = "./generated"
    generator["simple_test"] = "hello!"

    generator.in_directory("sample") do
      generator.file "sample_file.cr", <<-RUBY
        hello_world
      RUBY

      generator.file "sample_file.cr", <<-RUBY
        def test
          <%= opts['simple_test'] %> with change
        end
      RUBY
    end
  end
end
