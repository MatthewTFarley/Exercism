""" Card Games module """

from statistics import median


def get_rounds(number: int) -> list[int]:
    """

    :param number: int - current round number.
    :return: list - current round and the two that follow.
    """

    return [number, number + 1, number + 2]


def concatenate_rounds(rounds_1: list[int], rounds_2: list[int]) -> list[int]:
    """

    :param rounds_1: list - first rounds played.
    :param rounds_2: list - second set of rounds played.
    :return: list - all rounds played.
    """

    return rounds_1 + rounds_2


def list_contains_round(rounds: list[int], number: int) -> bool:
    """

    :param rounds: list - rounds played.
    :param number: int - round number.
    :return:  bool - was the round played?
    """

    return number in rounds


def card_average(hand: list[int]) -> float:
    """

    :param hand: list - cards in hand.
    :return:  float - average value of the cards in the hand.
    """

    return sum(hand) / len(hand)


def approx_average_is_average(hand: list[int]) -> bool:
    """

    :param hand: list - cards in hand.
    :return: bool - if approximate average equals to the `true average`.
    """

    actual_average = card_average(hand)
    first_last_average = sum([hand[0], hand[-1]]) / 2
    middle_card = median(hand)
    return actual_average in (first_last_average, middle_card)


def average_even_is_average_odd(hand: list[int]) -> bool:
    """

    :param hand: list - cards in hand.
    :return: bool - are even and odd averages equal?
    """

    evens = []
    odds = []
    for card in hand:
        if card % 2 == 0:
            evens.append(card)
        else:
            odds.append(card)
    return sum(evens) / len(evens) == sum(odds) / len(odds)


def maybe_double_last(hand: list[int]) -> list[int]:
    """

    :param hand: list - cards in hand.
    :return: list - hand with Jacks (if present) value doubled.
    """

    return list(map(lambda card: card * 2 if card == 11 else card, hand))
