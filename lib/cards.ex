defmodule Cards do

  # comprehension
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = [ "Spades", "Clubs", "Hearts", "Diamonds"]
    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  # method with ? in the name = returns a boolean value (like a question...Does it contain xyz? yes/no)
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def save(deck, filename) do
    binaray = :erlang.term_to_binary(deck)
    File.write(filename, binaray)
  end

  def load(filename) do
    {status, binary} = File.read(filename)
    case status do
      :ok -> :erlang.binary_to_term(binary)
      :error -> "File does not exist"
    end
  end

  def deal(deck, hand_size) do
    d = shuffle(deck)
    Enum.split(d, hand_size)
  end
end
