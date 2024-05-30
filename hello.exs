IO.puts("Hello, World!")

# Basic functions
#

# sum = fn a, b -> a + b end

handle_open = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

res = handle_open.(File.open("README.md"))

IO.puts(res)
