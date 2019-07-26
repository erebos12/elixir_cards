defmodule Cards do
  @moduledoc """
    Provides methods for create and hanlding a deck of cards.
  """

  # comprehension
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
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
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist"
      # _ = ignore this variable
    end
  end

  @doc """
  Devides a deck into a hand and remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    d = shuffle(deck)
    Enum.split(d, hand_size)
  end

  # use consinstent FIRST argument for functions
  # when using pipe operator - here 'deck'
  def create_hand(hand_size) do
    create_deck()
    |> shuffle
    |> deal(hand_size)
  end

end
