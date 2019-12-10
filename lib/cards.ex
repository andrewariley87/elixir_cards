defmodule Cards do
  def create_deck do
    values = ["Ace", "King", "Queen", "Jack", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    suits  = ["Hearts", "Diamonds", "Clubs", "Spades"]
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  def load(file_name) do
    case File.read(file_name) do
      {:ok, deck} -> :erlang.binary_to_term(deck)
      {:error, _reason} -> "#{file_name} does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
