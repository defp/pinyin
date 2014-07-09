defmodule Pinyin do
  import Ascii

  data_path = Path.join(__DIR__, "data/Mandarin.dat")

  codes = Enum.reduce File.stream!(data_path), [], fn(line, acc) ->
    [code, pinyin]  = String.split line, " "
    [{code, pinyin} | acc]
  end

  for {code, pinyin} <- codes do
    integer_code = String.to_integer(code, 16)
    pinyins = pinyin |> String.rstrip |> String.split(",")

    defp get_pinyin(unquote(integer_code)) do
      unquote(List.first(pinyins))
    end
  end

  defp get_pinyin(other) do
    << other :: utf8 >>
  end

  def pinyin(han) do
    Enum.map(parse_codepoints(han), fn(ch) ->
      if String.length(ch) == 1 do
        << codepoint :: utf8 >> = ch
        get_pinyin(codepoint)
      else
        ch
      end
    end)
  end

  def letter_with_tone(han) do
    pinyin(han) |> 
    Enum.map(fn(ch) -> pinyin_to_ascii_with_tone(ch) end)
  end

  def letter(han) do
    pinyin(han) |> 
    Enum.map(fn(ch) -> pinyin_to_ascii(ch) end)
  end

  def permlink(han, sep \\ "-") do
    pinyin(han) 
    |> Enum.map(fn(ch) -> pinyin_to_ascii(ch) end)
    |> Enum.join sep
  end

  defp parse_codepoints(han) do
    String.codepoints(han) |> classify_letter_number
  end

  # join letter codepoints in a word
  # ["到", "阿", "a", "s", "d", "f", "a", "a", "s", "f"]
  # transform =>
  # ["到", "阿", "asdfaasf"]
  defp classify_letter_number([]), do: []
  defp classify_letter_number([a]), do: [a]

  defp classify_letter_number(list) do
    [a, b | rest] = list
    cond do
      !is_english_number?(b) -> [a, b | classify_letter_number(rest)]
      !is_english_number?(a) -> [a | classify_letter_number([b | rest])]
      true -> classify_letter_number([a <> b | rest])
    end
  end

  defp is_english_number?(str) do
    number = if String.length(str) == 1 do
      << val :: utf8 >> = str
      val
    else
      << val :: utf8 >> = String.last(str)
      val
    end
    ( number >= 97 and number <= 122 ) or # a-z
    ( number >= 65 and number <= 90 ) or # A-Z
    ( number >= 48 and number <= 57 ) # 0-9
  end
end
