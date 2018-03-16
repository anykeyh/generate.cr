# Generate.cr

## Abstract

This small shards is useful to create project generators, wizard etc...

It provides few helpers method to create new folders, template files and execute
applications.

## Usage

Add it to your shard.yml:

```yaml
  dependencies:
    generate-cr:
      github: anykeyh/generate.cr
```

Create a new generator:

```crystal
  g = Generate::Generator.new
  # Setup initial directory
  g.target_directory = "./generated"
  # Setup variables into the generator.
  g["simple_test"] = "hello!"

  # Change the current working directory
  g.in_directory("sample") do
    g.file "sample_file.cr", <<-RUBY
      def test
        $simple_test
      end
    RUBY

    g.file "another_file.cr", <<-RUBY
      def test
        $simple_test
      end
    RUBY
  end
```