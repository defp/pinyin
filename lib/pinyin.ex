defmodule Pinyin do
  import Utils

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

  # get value by utf8 code
  # example:
  # iex(4)> <<97::utf8>>
  # "a"
  defp get_pinyin(other) do
    << other :: utf8 >>
  end

  @spec pinyin(binary) :: [binary]
  def pinyin(han) do
    Enum.map(parse_codepoints(han), fn(ch) ->
      if String.length(ch) == 1 do
        << int_val :: utf8 >> = ch
        get_pinyin(int_val)
      else
        ch
      end
    end)
  end

  @spec letter_with_tone(binary) :: [binary]
  def letter_with_tone(han) do
    pinyin(han) |>
    Enum.map(fn(ch) -> pinyin_to_ascii(ch, true) end)
  end

  @spec letter(binary) :: [binary]
  def letter(han) do
    pinyin(han) |>
    Enum.map(fn(ch) -> pinyin_to_ascii(ch, false) end)
  end

  @spec permlink(binary) :: binary
  def permlink(han, sep \\ "-") do
    pinyin(han)
    |> Enum.map(fn(ch) -> pinyin_to_ascii(ch, false) end)
    |> Enum.join(sep)
  end

end
