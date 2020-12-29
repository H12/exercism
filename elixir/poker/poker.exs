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
  def best_hand(hands), do: best_hand(hands, [])

  def best_hand([], best_hands), do: Enum.reverse(best_hands)
  def best_hand([next_hand | remaining_hands], []), do: best_hand(remaining_hands, [next_hand])

  def best_hand([next_hand | remaining_hands], best_hands) do
    case compare(next_hand, hd(best_hands)) do
      :gt -> best_hand(remaining_hands, [next_hand])
      :lt -> best_hand(remaining_hands, best_hands)
      _ -> best_hand(remaining_hands, [next_hand | best_hands])
    end
  end

  def compare(hand_1, hand_2) do
    case {value_hierarchy(hand_1), value_hierarchy(hand_2)} do
      {first, second} when first > second -> :gt
      {first, second} when first < second -> :lt
      _ -> :eq
    end
  end

  def value_hierarchy(hand) do
    {
      straight_flush?(hand),
      four_of_a_kind_value(hand),
      full_house_values(hand),
      flush?(hand),
      straight_value(hand),
      three_of_a_kind_value(hand),
      two_pair_values(hand),
      pair_value(hand),
      high_value(hand)
    }
  end

  def duplicate_card_values(hand, num_occurences) do
    hand
    |> values
    |> Enum.frequencies()
    |> Enum.filter(fn {_card_value, card_count} -> card_count == num_occurences end)
    |> Enum.map(fn {card_value, _card_count} -> card_value end)
    |> Enum.sort(:desc)
  end

  def four_of_a_kind_value(hand), do: duplicate_card_values(hand, 4)

  def full_house_values(hand) do
    triplets = duplicate_card_values(hand, 3)
    doublets = duplicate_card_values(hand, 2)

    if length(triplets) == 1 && length(doublets) == 1 do
      List.flatten(triplets, doublets)
    else
      []
    end
  end

  def three_of_a_kind_value(hand), do: duplicate_card_values(hand, 3)

  def two_pair_values(hand) do
    pairs = duplicate_card_values(hand, 2)

    if length(pairs) == 2 do
      pairs
    else
      []
    end
  end

  def pair_value(hand), do: duplicate_card_values(hand, 2)
  def high_value(hand), do: duplicate_card_values(hand, 1)

  def straight_flush?(hand) do
    straight_value(hand) != {} && flush?(hand)
  end

  def flush?(hand) do
    hand
    |> suits
    |> all_the_same?
  end

  def all_the_same?(enum) do
    enum
    |> Enum.uniq()
    |> (fn unique -> Enum.count(unique) == 1 end).()
  end

  def straight_value(hand) do
    sorted_values =
      hand
      |> values()
      |> Enum.sort()

    if all_increment_by_one?(sorted_values) do
      {Enum.max(sorted_values)}
    else
      if sorted_values == [0, 1, 2, 3, 12] do
        {3}
      else
        {}
      end
    end
  end

  def all_increment_by_one?(list) do
    all_different?(list) && min_max_diff_by?(list, length(list) - 1)
  end

  def all_different?(enum) do
    enum
    |> Enum.uniq()
    |> (fn unique -> Enum.count(unique) == length(enum) end).()
  end

  def min_max_diff_by?(list, diff_value) do
    {min, max} = Enum.min_max(list)

    max - min == diff_value
  end

  def suits(hand) do
    hand
    |> Enum.map(&split_card/1)
    |> Enum.map(fn {_value, suit} -> suit end)
  end

  def values(hand) do
    hand
    |> Enum.map(&split_card/1)
    |> Enum.map(fn {value, _suit} -> value end)
    |> Enum.map(&numerical_value(&1, ace_type))
  end

  def split_card(card), do: String.split_at(card, -1)

  def numerical_value(card_value) do
    case card_value do
      "2" -> 0
      "3" -> 1
      "4" -> 2
      "5" -> 3
      "6" -> 4
      "7" -> 5
      "8" -> 6
      "9" -> 7
      "10" -> 8
      "J" -> 9
      "Q" -> 10
      "K" -> 11
      "A" -> 12
    end
  end
end
