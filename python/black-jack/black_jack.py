"""Functions to help play and score a game of blackjack.

How to play blackjack:    https://bicyclecards.com/how-to-play/blackjack/
"Standard" playing cards: https://en.wikipedia.org/wiki/Standard_52-card_deck
"""


def value_of_card(card):
    """Determine the scoring value of a card.

    :param card: str - given card.
    :return: int - value of a given card. 'J', 'Q', 'K' = 10; 'A' = 1; numerical value otherwise.
    """

    return {
        'A': 1,
        'J': 10,
        'Q': 10,
        'K': 10
    }.get(card) or int(card)


def higher_card(card_one, card_two):
    """Determine which card has a higher value in the hand.

    :param card_one, card_two: str - cards dealt. 'J', 'Q', 'K' = 10; 'A' = 1; numerical value otherwise.
    :return: higher value card - str. Tuple of both cards if they are of equal value.
    """

    card_one_value, card_two_value = list(map(value_of_card, [card_one, card_two]))

    if card_one_value > card_two_value:
        return card_one

    if card_one_value < card_two_value:
        return card_two

    return (card_one, card_two)


def value_of_ace(card_one, card_two):
    """Calculate the most advantageous value for the ace card.

    :param card_one, card_two: str - card dealt. 'J', 'Q', 'K' = 10; 'A' = 11 (if already in hand); numerical value otherwise.
    :return: int - value of the upcoming ace card (either 1 or 11).
    """
    card_one_is_ace = card_one == 'A'
    card_two_is_ace = card_two == 'A'
    both_are_aces = card_one_is_ace and card_two_is_ace
    neither_are_aces = not card_one_is_ace and not card_two_is_ace
    sum_of_card_values = value_of_card(card_one) + value_of_card(card_two)
    sum_of_card_values_plus_eleven_is_less_than_22 = sum_of_card_values + 11 < 22

    if both_are_aces or neither_are_aces and sum_of_card_values_plus_eleven_is_less_than_22:
        return 11

    return 1


def is_blackjack(card_one, card_two):
    """Determine if the hand is a 'natural' or 'blackjack'.

    :param card_one, card_two: str - cards dealt. 'J', 'Q', 'K' = 10; 'A' = 11; numerical value otherwise.
    :return: bool - if the hand is a blackjack (two cards worth 21).
    """

    return card_one == 'A' and value_of_card(card_two) == 10 or card_two == 'A' and value_of_card(card_one) == 10


def can_split_pairs(card_one, card_two):
    """Determine if a player can split their hand into two hands.

    :param card_one, card_two: str - cards dealt.
    :return: bool - if the hand can be split into two pairs (i.e. cards are of the same value).
    """

    return value_of_card(card_one) == value_of_card(card_two)


def can_double_down(card_one, card_two):
    """Determine if a blackjack player can place a double down bet.

    :param card_one, card_two: str - first and second cards in hand.
    :return: bool - if the hand can be doubled down (i.e. totals 9, 10 or 11 points).
    """

    return value_of_card(card_one) + value_of_card(card_two) in [9, 10, 11]
