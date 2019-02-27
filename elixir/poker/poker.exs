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
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    hands
    |> check_ranks
  end

  # def check_pairs(hands) do
  #   pairs = Enum.map(hands, fn hand -> hand(hand) == length(Enum.uniq_by(hand, &map_rank/1)) end)

  #   cond do
  #     length(pairs) > 0 ->
  #       pairs
  #     true -> hands
  #   end
  # end

  def check_ranks(hands) do
    first = List.first(hands)
    last = List.last(hands)

    cond do
      length(hands) == 1 ->
        hands
      highest_card(first) == highest_card(last) ->
        cond do
          sum_hand(first) < sum_hand(last) ->
            [last]
          sum_hand(first) > sum_hand(last) ->
            [first]
          true -> hands
        end
      highest_card(first) > highest_card(last) ->
        check_ranks(Enum.drop(hands, -1))
      true -> check_ranks(Enum.drop(hands, 1))
    end
  end

  def highest_card(hand) do
    Enum.max_by(hand, &map_rank/1)
    |> String.slice(0..-2)
  end

  def map_rank(value_string) do
    rank_map = %{
      "2" => 0,
      "3" => 1,
      "4" => 2,
      "5" => 3,
      "6" => 4,
      "7" => 5,
      "8" => 6,
      "9" => 7,
      "10" => 8,
      "J" => 9,
      "Q" => 10,
      "K" => 11,
      "A" => 12
    }

    value = String.slice(value_string, 0..-2)
    rank_map[value]
  end

  def sum_hand(hand) do
    Enum.reduce(hand, 0, fn value, sum -> map_rank(value) + sum end)
  end
end
