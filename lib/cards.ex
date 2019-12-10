defmodule Cards do
  @moduledoc """
    Gives users the ability to create, handle, and deal cards.
  """

  @doc """
    Creates a deck represented by list of strings.

  ## Examples
      iex> Cards.create_deck
      ["Ace of Hearts", "King of Hearts", "Queen of Hearts", "Jack of Hearts", "Two of Hearts", "Three of Hearts",
       "Four of Hearts", "Five of Hearts", "Six of Hearts", "Seven of Hearts", "Eight of Hearts", "Nine of Hearts",
       "Ten of Hearts", "Ace of Diamonds", "King of Diamonds", "Queen of Diamonds", "Jack of Diamonds", "Two of Diamonds",
       "Three of Diamonds", "Four of Diamonds", "Five of Diamonds", "Six of Diamonds", "Seven of Diamonds",
       "Eight of Diamonds", "Nine of Diamonds", "Ten of Diamonds", "Ace of Clubs", "King of Clubs", "Queen of Clubs",
       "Jack of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs", "Five of Clubs", "Six of Clubs", "Seven of Clubs",
       "Eight of Clubs", "Nine of Clubs", "Ten of Clubs", "Ace of Spades", "King of Spades", "Queen of Spades",
       "Jack of Spades", "Two of Spades", "Three of Spades", "Four of Spades", "Five of Spades", "Six of Spades",
       "Seven of Spades", "Eight of Spades", "Nine of Spades", "Ten of Spades"]
  """
  def create_deck do
    values = ["Ace", "King", "Queen", "Jack", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    suits  = ["Hearts", "Diamonds", "Clubs", "Spades"]
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
   Shuffles the deck into a random order.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Lets a user if the deck still contains a card.

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Two of Hearts")
      true

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Not a Real Card")
      false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end
  @doc """
    Divides the deck into two parts the first part is hand and the second is the remaining cards in the deck.
    The `hand_size` argument determines how many cards will be in the users hand.

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Hearts"]
  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves a deck to a file to be used later

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.save(deck, 'unused_deck')
      :ok
  """
  def save(deck, file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  @doc """
    Will load a saved deck given a file name.

  ## Examples
      iex> Cards.load('new_deck')
      Cards.create_deck

      iex> Cards.load('not_a_saved_file')
      "not_a_saved_file does not exist"
  """
  def load(file_name) do
    case File.read(file_name) do
      {:ok, deck} -> :erlang.binary_to_term(deck)
      {:error, _reason} -> "#{file_name} does not exist"
    end
  end

  @doc """
  Creates a deck, shuffles it, and then deals a hand based on the `hand_size` argument.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
