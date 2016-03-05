defmodule PinyinTest do
  use ExUnit.Case

  test "pinyin func" do
    assert Pinyin.pinyin("Elixir编程语言") == ["Elixir", "biān", "chéng", "yǔ", "yán"]
  end

  test "letter func" do 
    assert Pinyin.letter("Elixir编程语言") == ["Elixir", "bian", "cheng", "yu", "yan"]
  end

  test "letter_with_tone func" do
    assert Pinyin.letter_with_tone("Elixir编程语言") == ["Elixir", "bian1", "cheng2", "yu3", "yan2"]
  end
  
  test "permlink func" do
    assert Pinyin.permlink("Elixir编程语言") == "Elixir-bian-cheng-yu-yan"
  end
end
