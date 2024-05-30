# Ex: Write a functio nthat takes three args, if the first two are zero, return FizzBuzz
# If the first is zero, return Fizz
# If the second is zero return Buzz
# Otherwise return the third arg

fizzbuzz = fn
  0, 0, _ -> IO.puts("FizzBuzz")
  0, _, _ -> IO.puts("Fizz")
  _, 0, _ -> IO.puts("Buzz")
  _, _, c -> IO.puts(c)
end

fb = fn n -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end

fb.(10)
fb.(11)
fb.(12)
fb.(15)

# exercise that contacs string, showcasing closure behavior
prefix = fn s -> fn og -> "#{s} #{og}" end end
prefix.("Mrs").("Jones")
