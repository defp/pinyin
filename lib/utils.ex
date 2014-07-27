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

  def pinyin_to_ascii(pinyin) do
    cond do
      String.contains? pinyin, "ā" -> String.replace(pinyin, "ā", "a")
      String.contains? pinyin, "á" -> String.replace(pinyin, "á", "a")
      String.contains? pinyin, "ǎ" -> String.replace(pinyin, "ǎ", "a")
      String.contains? pinyin, "à" -> String.replace(pinyin, "à", "a")

      String.contains? pinyin, "ē" -> String.replace(pinyin, "ē", "e")
      String.contains? pinyin, "é" -> String.replace(pinyin, "é", "e")
      String.contains? pinyin, "ě" -> String.replace(pinyin, "ě", "e")
      String.contains? pinyin, "è" -> String.replace(pinyin, "è", "e")

      String.contains? pinyin, "ī" -> String.replace(pinyin, "ī", "i")
      String.contains? pinyin, "í" -> String.replace(pinyin, "í", "i")
      String.contains? pinyin, "ǐ" -> String.replace(pinyin, "ǐ", "i")
      String.contains? pinyin, "ì" -> String.replace(pinyin, "ì", "i")

      String.contains? pinyin, "ō" -> String.replace(pinyin, "ō", "o")
      String.contains? pinyin, "ó" -> String.replace(pinyin, "ó", "o")
      String.contains? pinyin, "ǒ" -> String.replace(pinyin, "ǒ", "o")
      String.contains? pinyin, "ò" -> String.replace(pinyin, "ò", "o")

      String.contains? pinyin, "ǖ" -> String.replace(pinyin, "ǖ", "v")
      String.contains? pinyin, "ǘ" -> String.replace(pinyin, "ǘ", "v")
      String.contains? pinyin, "ǚ" -> String.replace(pinyin, "ǚ", "v")
      String.contains? pinyin, "ǜ" -> String.replace(pinyin, "ǜ", "v")

      String.contains? pinyin, "ū" -> String.replace(pinyin, "ū", "v")
      String.contains? pinyin, "ú" -> String.replace(pinyin, "ú", "v")
      String.contains? pinyin, "ǔ" -> String.replace(pinyin, "ǔ", "v")
      String.contains? pinyin, "ù" -> String.replace(pinyin, "ù", "v")

      String.contains? pinyin, "üē" -> String.replace(pinyin, "üē", "ue")
      String.contains? pinyin, "üé" -> String.replace(pinyin, "üé", "ue")
      String.contains? pinyin, "üě" -> String.replace(pinyin, "üě", "ue")
      String.contains? pinyin, "üè" -> String.replace(pinyin, "üè", "ue")

      true -> pinyin
    end
  end

  def pinyin_to_ascii_with_tone(pinyin) do
    cond do
      String.contains? pinyin, "ā" -> String.replace(pinyin, "ā", "a")  <> "1"
      String.contains? pinyin, "á" -> String.replace(pinyin, "á", "a")  <> "2"
      String.contains? pinyin, "ǎ" -> String.replace(pinyin, "ǎ", "a")  <> "3"
      String.contains? pinyin, "à" -> String.replace(pinyin, "à", "a")  <> "4"

      String.contains? pinyin, "ē" -> String.replace(pinyin, "ē", "e")  <> "1"
      String.contains? pinyin, "é" -> String.replace(pinyin, "é", "e")  <> "2"
      String.contains? pinyin, "ě" -> String.replace(pinyin, "ě", "e")  <> "3"
      String.contains? pinyin, "è" -> String.replace(pinyin, "è", "e")  <> "4"

      String.contains? pinyin, "ī" -> String.replace(pinyin, "ī", "i")  <> "1"
      String.contains? pinyin, "í" -> String.replace(pinyin, "í", "i")  <> "2"
      String.contains? pinyin, "ǐ" -> String.replace(pinyin, "ǐ", "i")  <> "3"
      String.contains? pinyin, "ì" -> String.replace(pinyin, "ì", "i")  <> "4"

      String.contains? pinyin, "ō" -> String.replace(pinyin, "ō", "o")  <> "1"
      String.contains? pinyin, "ó" -> String.replace(pinyin, "ó", "o")  <> "2"
      String.contains? pinyin, "ǒ" -> String.replace(pinyin, "ǒ", "o")  <> "3"
      String.contains? pinyin, "ò" -> String.replace(pinyin, "ò", "o")  <> "4"

      String.contains? pinyin, "ǖ" -> String.replace(pinyin, "ǖ", "v")  <> "1"
      String.contains? pinyin, "ǘ" -> String.replace(pinyin, "ǘ", "v")  <> "2"
      String.contains? pinyin, "ǚ" -> String.replace(pinyin, "ǚ", "v")  <> "3"
      String.contains? pinyin, "ǜ" -> String.replace(pinyin, "ǜ", "v")  <> "4"

      String.contains? pinyin, "ū" -> String.replace(pinyin, "ū", "v")  <> "1"
      String.contains? pinyin, "ú" -> String.replace(pinyin, "ú", "v")  <> "2"
      String.contains? pinyin, "ǔ" -> String.replace(pinyin, "ǔ", "v")  <> "3"
      String.contains? pinyin, "ù" -> String.replace(pinyin, "ù", "v")  <> "4"

      String.contains? pinyin, "üē" -> String.replace(pinyin, "üē", "ue") <> "1"
      String.contains? pinyin, "üé" -> String.replace(pinyin, "üé", "ue") <> "2"
      String.contains? pinyin, "üě" -> String.replace(pinyin, "üě", "ue") <> "3"
      String.contains? pinyin, "üè" -> String.replace(pinyin, "üè", "ue") <> "4"

      true -> pinyin
    end
  end
end
