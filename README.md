Pinyin for Elixir
=========================

简单的汉字转拼音工具 

## Example:

```iex
iex(40)> Pinyin.pinyin "Elixir编程语言"
["Elixir", "biān", "chéng", "yǔ", "yán"]
iex(41)> Pinyin.letter "Elixir编程语言"
["Elixir", "bian", "cheng", "yv", "yan"]
iex(42)> Pinyin.letter_with_tone "Elixir编程语言"
["Elixir", "bian1", "cheng2", "yv3", "yan2"]
iex(43)> Pinyin.permlink "Elixir编程语言"
"Elixir-bian-cheng-yv-yan"
iex(44)>
```
## thanks

The pinyin data library from ruby-pinyin project:

https://github.com/janx/ruby-pinyin

