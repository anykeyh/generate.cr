module Diff
  def self.diff(string_a, string_b)
    # Create temporary files
    a = File.tempfile("diff_a")
    File.write(a.path, string_a)

    b = File.tempfile("diff_b")
    File.write(b.path, string_b)

    begin
      system("diff -u #{b.path} #{a.path} | more")
    ensure
      a.delete
      b.delete
    end
  end
end
