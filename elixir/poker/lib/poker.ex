defmodule Poker do
  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """

  @rank_map %{
    "2" => 1,
    "3" => 2,
    "4" => 3,
    "5" => 4,
    "6" => 5,
    "7" => 6,
    "8" => 7,
    "9" => 8,
    "10" => 9,
    "J" => 10,
    "Q" => 11,
    "K" => 12,
    "A" => 13
  }

  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    [first_hand | remaining_hands] = hands

    best_hand(remaining_hands, [first_hand])
  end

  def best_hand([], best_hands), do: best_hands

  def best_hand(hands, winning_hands) do
    [high_hand | _] = winning_hands
    [next_hand | remaining_hands] = hands

    case compare(high_hand, next_hand) do
      :gt -> best_hand(remaining_hands, [high_hand])
      :lt -> best_hand(remaining_hands, [next_hand])
      :eq -> best_hand(remaining_hands, [next_hand | winning_hands])
    end
  end

  def pair?(hand) do
    hand
    |> Enum.frequencies_by(&rank/1)
  end

  def compare(hand_a, hand_b) do
    ranked_hand_a =
      hand_a
      |> Enum.frequencies_by(&rank/1)

    ranked_hand_b =
      hand_b
      |> Enum.frequencies_by(&rank/1)

    compare_ranked(ranked_hand_a, ranked_hand_b)
  end

  def compare_ranked(hand_a, hand_b) do
    sorted_hand_a =
      hand_a
      |> Map.keys()
      |> Enum.map(&Map.get(@rank_map, &1))
      |> Enum.sort()

    sorted_hand_b =
      hand_b
      |> Map.keys()
      |> Enum.map(&Map.get(@rank_map, &1))
      |> Enum.sort()

    if sorted_hand_a == sorted_hand_b do
      :eq
    else
      case sorted_hand_a > sorted_hand_b do
        true -> :gt
        false -> :lt
      end
    end
  end

  defp rank(card) do
    {rank, _suit} = String.split_at(card, -1)
    rank
  end
end
