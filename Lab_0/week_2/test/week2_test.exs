defmodule Week2Test do
  use ExUnit.Case
  doctest Week2

  test "Check_primelity" do
    assert Week2.isPrime(13) == True
  end

  test "Reverse_list" do
    assert Week2.reverse([1, 2, 4, 8, 4]) == [4, 8, 4, 2, 1]
  end

  test "Uniques_sum" do
    assert Week2.uniqueSum([1, 2, 4, 8, 4, 2]) == 15
  end

  test "First_n_Fibonacci" do
    assert Week2.firstFibonacciElements(7) == [1, 1, 2, 3, 5, 8, 13]
  end

  test "Translator" do
    assert Week2.translator([mama: "mother", papa: "father"], "mama is with papa") ==
      "mother is with father"
  end

  test "Smallest_number" do
    assert Week2.smallestNumber(4, 5, 3) == 345
  end

  test "Smallest_number_zero" do
    assert Week2.smallestNumber(0, 3, 4) == 304
  end

  test "Left_shift" do
    assert Week2.rotateLeft([1, 2, 4, 8, 4], 3) == [8, 4, 1, 2, 4]
  end

  test "Remove_consecutive_duplicates" do
    assert Week2.removeConsecutiveDuplicates([1, 2, 2, 2, 4, 8, 4]) ==
      [1, 2, 4, 8, 4]
  end

  test "Line_words" do
    assert Week2.lineWords(["Hello", "Alaska", "Dad", "Peace"]) == ["Alaska", "Dad"]
  end

  test "Caesar_ciher_encode" do
    assert Week2.encode("lorem", 3) == "oruhp"
  end

  test "Caesar_ciher_decode" do
    assert Week2.decode("oruhp", 3) == "lorem"
  end

  test "Convert_to_roman" do
    assert Week2.toRoman("13") == "XIII"
  end

  test "Prima factorization" do
    assert Week2.factorize(42) == [7, 3, 2]
  end


end
