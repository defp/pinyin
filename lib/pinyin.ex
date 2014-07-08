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

    defp single_pinyin(unquote(integer_code)) do
      unquote(List.first(pinyins))
    end
  end

  defp single_pinyin(other) do
    << other :: utf8 >>
  end

  def pinyin(han) do
    Enum.map String.codepoints(han), fn(ch) ->
      << codepoint :: utf8 >> = ch
      single_pinyin(codepoint)
    end
  end

  def letter(han) do
    Enum.map String.codepoints(han), fn(ch) ->
      << codepoint :: utf8 >> = ch
      pinyin_to_ascii_with_tone(single_pinyin(codepoint))
    end
  end

  def permlink(han, sep \\ "-") do
    pinyins = Enum.map String.codepoints(han), fn(ch) ->
      << codepoint :: utf8 >> = ch
      pinyin_to_ascii(single_pinyin(codepoint))
    end
    Enum.join pinyins, sep
  end
end
