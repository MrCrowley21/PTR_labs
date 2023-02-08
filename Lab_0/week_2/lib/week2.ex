defmodule Week2 do

### Minimal Task ###

# Write a function that determines whether an input integer is prime.

def isPrime(n) when n <= 1 do
  False
end
def isPrime(n) when (n == 2) or (n == 3) do
  True
end
def isPrime(n) do
  current_state =
  for i <- 2..trunc(:math.sqrt(n)) do
    if rem(n, i) == 0 do
      true
    else
      false
      end
    end
  _is_prime =
  if Enum.any?(current_state) do
    False
  else
    True
  end
end

# Write a function to calculate the area of a cylinder, given it’s height and radius.

def cylinderArea(height, radius) do
  cylinder_area = 2 * :math.pi * radius * (radius + height)
  :erlang.float_to_binary(cylinder_area, [decimals: 4])
end

# Write a function to reverse a list.

def reverse(input_list) do
  put_front(input_list, [])
end

defp put_front([first | last], acc) do
  put_front(last, [first | acc])
end

defp put_front([], acc) do
  acc
end

# Write a function to calculate the sum of unique elements in a list.

def uniqueSum(input_list) do
  sumUniqueList(input_list, [], 0)
end

defp sumUniqueList([first | last], unique_list, sum) do
  if ! (first in  unique_list) do
    sum = sum + first
    sumUniqueList(last, [first | unique_list], sum)
  else
    sumUniqueList(last, unique_list, sum)
  end
end

defp sumUniqueList([], _unique_list, sum) do
  sum
end

# Write a function that extracts a given number of randomly selected elements from a list.

def extractRandomN(input_list, n) do
  getRandomElements(input_list, n, [])
end

defp getRandomElements(input_list, i, numbers) when i > 0 do
  getRandomElements(input_list, i - 1, [Enum.at(input_list, :rand.uniform(length(input_list) - 1)) | numbers])
end

defp getRandomElements(_input_list, i, numbers) when i == 0 do
  numbers
end

# Write a function that returns the first n elements of the Fibonacci sequence.

def firstFibonacciElements(n) when n == 1 do
  [1]
end

def firstFibonacciElements(n) when n == 2 do
  [1, 1]
end

def firstFibonacciElements(n) do
  getFibonacciElement([1, 1], n)
end

defp getFibonacciElement(input_list, 2) do
  Enum.reverse(input_list)
end

defp getFibonacciElement(input_list, n) do
  [first, second | _rest] = input_list
  getFibonacciElement([first + second | input_list], n - 1)
end

# Write a function that, given a dictionary, would translate a sentence. Words
# not found in the dictionary need not be translated.

def translator(dictionary, original_string) do
  dict_values = Enum.into(dictionary, HashDict.new())
  Enum.join(replace_string(dict_values, original_string), " ")
end

defp replace_string(dictionary, original_string) do
  string_list = String.split(original_string, " ")
  for value <- string_list do
    HashDict.get(dictionary, String.to_atom(value), value)
  end
end

# Write a function that receives as input three digits and arranges them in an
# order that would create the smallest possible number. Numbers cannot start with a 0.

def smallestNumber(a, b, c) do
  number_array = Enum.sort([a, b, c])
  number_array =
  if Enum.at(number_array, 0) == 0 do
    swap(number_array, 0, 1)
  else
    number_array
  end
  get_number(number_array, 100)
end

defp swap(list, index_1, index_2) do
  element_1 = Enum.at(list, index_1)
  element_2 = Enum.at(list, index_2)
  list
  |> List.replace_at(index_1, element_2)
  |> List.replace_at(index_2, element_1)
end

defp get_number([first | list], mulx) do
  _number = first * mulx + get_number(list, div(mulx, 10))
end

defp get_number([], _mulx) do
  0
end

# Write a function that would rotate a list n places to the left.

def rotateLeft(input_list, n) when n == 0 do
  input_list
end

def rotateLeft([first | list], n) do
  rotateLeft(list ++ [first], n - 1)
end

# Write a function that lists all tuples a, b, c such that a

def listRightAngleTriangles() do
  check_a(1, [])
end

defp check_a(current_value, tuple_list) do
  if current_value < 20 do
    tuple_list = check_b(current_value, 1, tuple_list)
    check_a(current_value + 1, tuple_list)
  else
    tuple_list
  end
end

defp check_b(a_value, current, tuple_list) do
  c_value = :math.sqrt(:math.pow(a_value, 2) + :math.pow(current, 2))
  current_tuple =
  if c_value == trunc(c_value) do
    [{a_value, current, trunc(c_value)}]
  else
    []
  end
  if current < 20 do
    tuple_list = tuple_list ++ current_tuple
    check_b(a_value, current + 1, tuple_list)
  else
    tuple_list ++ current_tuple
  end
end

### Main Task ###

# Write a function that eliminates consecutive duplicates in a list.

def removeConsecutiveDuplicates(input_list) do
  deleteDuplicate(input_list, 1)
end

defp deleteDuplicate(input_list, element_index) when element_index == length(input_list) do
  input_list
end

defp deleteDuplicate(input_list, element_index) do
  if Enum.at(input_list, element_index) == Enum.at(input_list, element_index - 1) do
    new_list = List.delete_at(input_list, element_index)
    deleteDuplicate(new_list, element_index)
  else
    deleteDuplicate(input_list, element_index + 1)
  end
end

# Write a function that, given an array of strings, will return the words that can
# be typed using only one row of the letters on an English keyboard layout.

def lineWords(input_array) do
  split_words = splitString(input_array)
  one_row_words =
  for word <- split_words do
    checkOneRow(word)
  end
  buildLineList(input_array, one_row_words, [])
end

defp splitString(input_array) do
  for word <- input_array do
    String.split(String.downcase(word), "")
  end
end

defp checkOneRow(word) do
  key_rows = %{0 => ["q","w","e","r","t","y","u","i","o","p", ""], 1 => ["a","s","d","f","g","h","j","k","l", ""],
  2 => ["z","x","c","v","b","n","m", ""]}
  word
  checkAppartenence(key_rows, word, 0)
end

defp checkAppartenence(_rows, _word, n) when n == 3 do
  false
end

defp checkAppartenence(rows, word, n) do
  if Enum.all?(word, &Enum.member?(rows[n], &1)) do
    true
  else
    checkAppartenence(rows, word, n + 1)
  end
end

defp buildLineList([], [], result) do
  result
end

defp buildLineList([first | list], [first_line | line_list], result) do
  if first_line do
    result = result ++ [first]
    buildLineList(list, line_list, result)
  else
    buildLineList(list, line_list, result)
  end
end

# Create a pair of functions to encode and decode strings using the Caesar cipher.

def encode(word, key) do
  string_list = prepareWord(word)
  result = applyFormula(string_list, key, [])
  Enum.join([result], "")
end

def decode(word, key) do
  string_list = prepareWord(word)
  result = applyFormula(string_list, -key, [])
  Enum.join([result], "")
end

defp prepareWord(word) do
  string_list = String.split(String.downcase(word), "")
  string_list = List.delete_at(string_list, length(string_list) - 1)
  List.delete_at(string_list, 0)
end

defp applyFormula([], _key, result) do
  result
end

defp applyFormula([first | list], key, result) do
  <<v::utf8>> = first
  result = result ++ [<<rem(v - ?a + key, 26) + 97::utf8>>]
  applyFormula(list, key, result)
end

# White a function that, given a string of digits from 2 to 9, would return all
# possible letter combinations that the number could represent (think phones with buttons).

def letterCombinations(input_string) do
  digits =
  for chr <- Enum.filter(String.split(input_string, ""), &(&1 != "")) do
    String.to_integer(chr)
  end
  getCombinations(digits, [''])
end

defp getCombinations([], result) do
  result
end

defp getCombinations([first| list], result) do
  digits = %{2 => 'abc', 3 => 'def', 4 => 'ghi',
            5 => 'jkl', 6 => 'mno', 7 => 'pqrs',
            8 => 'tuv', 9 => 'wxyz'}
  combinations =
  for comb <- result, chr <- digits[first] do
    comb ++ [chr]
  end
  getCombinations(list, combinations)
end

# White a function that, given an array of strings, would group the anagrams
# together.

def groupAnagrams(input_list) do
  anagrams = %{}
  string_words =
  for word <- input_list do
    prepared = prepareWord(word)
    Enum.sort(prepared)
  end
  resolveAnagrams(input_list, string_words, %{})
end

defp resolveAnagrams([], [], dict) do
  dict
end

defp resolveAnagrams([first | list], [first_sorted | sorted_words], dict) do
  if Map.has_key?(dict, String.to_atom(Enum.join(first_sorted, ""))) do
    key = String.to_atom(Enum.join(first_sorted, ""))
    value = [first |dict[key]]
    dict = Map.put(dict, String.to_atom(Enum.join(first_sorted, "")), value)
    resolveAnagrams(list, sorted_words, dict)
  else
    dict = Map.put(dict, String.to_atom(Enum.join(first_sorted, "")), [first])
    resolveAnagrams(list, sorted_words, dict)
  end
end

### Bonus Task ###

# Write a function to find the longest common prefix string amongst a list of strings.

def commonPrefix(input_list) do
  sorted_list = Enum.sort(input_list)
  string_1 = Enum.at(input_list, -1)
  string_2 = Enum.at(input_list, -2)
  getPrefix(string_1, string_2, min(String.length(string_1), String.length(string_2)), "", 0)
end

defp getPrefix(string_1, string_2, max_len, result, len) when max_len == len do
  result
end

defp getPrefix(string_1, string_2, max_len, result, len) do
  if String.at(string_1, len) == String.at(string_2, len) do
    getPrefix(string_1, string_2, max_len, result <> String.at(string_1, len), len + 1)
  else
    result
  end
end

# Write a function to convert arabic numbers to roman numerals.

def toRoman(input_number) do
  numbers_map = %{1000 => "M", 900 => "CM", 500 => "D", 400 => "CD", 100 => "C", 90 => "XC",
                  50 => "L", 40 => "XL", 10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 =>"I" }
  number = String.to_integer(input_number)
  buildRoman(number, numbers_map, "")
end

defp buildRoman(number, numbers_map, result) when number == 0 do
  result
end

defp buildRoman(number, numbers_map, result) do
  replaced_val = Enum.find(Enum.reverse(Enum.sort(Map.keys(numbers_map))),
                  fn roman_value -> roman_value <= number end)
  buildRoman(number - replaced_val, numbers_map, result <> numbers_map[replaced_val])
end

# Write a function to calculate the prime factorization of an integer.

def factorize(number) do
  factors = getFactors(2, number, [])
  IO.inspect factors, char_lists: false
end

def getFactors(candidate, number, factors) when candidate > number do
  factors
end

def getFactors(candidate, number, factors) when candidate <= number do
  if rem(number, candidate) == 0 and isPrime(candidate) == True do
    getFactors(candidate + 1 , number, [candidate | factors])
  else
    getFactors(candidate + 1 , number, factors)
  end
end

end
