module Diff
  def self.diff(string_a, string_b)
    # Create temporary files
    a = Tempfile.new("diff_a")
    File.write(a.path, string_a)

    b = Tempfile.new("diff_b")
    File.write(b.path, string_b)

    begin
      system("diff -u #{b.path} #{a.path} | more")
    ensure
      a.delete
      b.delete
    end
  end
end
