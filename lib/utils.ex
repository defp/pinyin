defmodule Utils do

  @spec parse_codepoints(binary) :: list
  def parse_codepoints(han) do
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

  @ascii_map [
    {"üē", "ue", "1"}, {"üé", "ue", "2"}, {"üě", "ue", "3"}, {"üè", "ue", "4"},
    {"ā", "a", "1"}, {"ē", "e", "1"}, {"ī", "i", "1"}, {"ō", "o", "1"}, {"ū", "u", "1"}, {"ǖ", "v", "1"},
    {"á", "a", "2"}, {"é", "e", "2"}, {"í", "i", "2"}, {"ó", "o", "2"}, {"ú", "u", "2"}, {"ǘ", "v", "2"},
    {"ǎ", "a", "3"}, {"ě", "e", "3"}, {"ǐ", "i", "3"}, {"ǒ", "o", "3"}, {"ǔ", "u", "3"}, {"ǚ", "v", "3"},
    {"à", "a", "4"}, {"è", "e", "4"}, {"ì", "i", "4"}, {"ò", "o", "4"}, {"ù", "u", "4"}, {"ǜ", "v", "4"}
  ]

  def pinyin_to_ascii(pinyin, with_tone) do
    do_to_ascii(@ascii_map, pinyin, with_tone)
  end

  defp do_to_ascii([{char, ascii, tone} | t], pinyin, with_tone) do
    if String.contains?(pinyin, char) do
      if with_tone do
        String.replace(pinyin, char, ascii) <> tone
      else
        String.replace(pinyin, char, ascii)
      end
    else
      do_to_ascii(t, pinyin, with_tone)
    end
  end

  defp do_to_ascii([], pinyin, _) do
    pinyin
  end
end
