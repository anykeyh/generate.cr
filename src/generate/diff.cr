module Diff
  def self.diff(string_a, string_b)
    # Create temporary files
    a = Tempfile.new("diff_a")
    File.write(a.path, string_a)

    b = Tempfile.new("diff_b")
    File.write(b.path, string_b)

    begin
      system("diff -u #{a.path} #{b.path} | more")
    ensure
      a.unlink
      b.unlink
    end
  end
end
