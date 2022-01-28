""" Tisbury Treasure Hunt module """

from typing import Tuple


def get_coordinate(record: Tuple[str, str]) -> str:
    """

    :param record: tuple - a (treasure, coordinate) pair.
    :return: str - the extracted map coordinate.
    """

    return record[1]


def convert_coordinate(coordinate: str) -> Tuple[str, str]:
    """

    :param coordinate: str - a string map coordinate
    :return:  tuple - the string coordinate seperated into its individual components.
    """

    number, letter = coordinate
    return (number, letter)


def compare_records(azara_record: Tuple[str, str], rui_record: Tuple[str, Tuple[str, str], str]) -> bool:
    """

    :param azara_record: tuple - a (treasure, coordinate) pair.
    :param rui_record: tuple - a (location, coordinate, quadrant) trio.
    :return: bool - True if coordinates match, False otherwise.
    """

    _, (treasure_1, coordinate_1) = azara_record
    _, (treasure_2, coordinate_2), _ = rui_record
    return (treasure_1, coordinate_1) == (treasure_2, coordinate_2)


def create_record(azara_record: Tuple[str, str], rui_record: Tuple[str, Tuple[str, str], str]) -> Tuple[str, str, str, Tuple[str, str], str, str] or str:
    """

    :param azara_record: tuple - a (treasure, coordinate) pair.
    :param rui_record: tuple - a (location, coordinate, quadrant) trio.
    :return:  tuple - combined record, or "not a match" if the records are incompatible.
    """

    if compare_records(azara_record, rui_record):
        treasure_1, coordinate_1 = azara_record
        treasure_2, coord_tuple, color = rui_record
        return (treasure_1, coordinate_1, treasure_2, coord_tuple, color)

    return 'not a match'


def clean_up(combined_record_group: Tuple[Tuple[str, str, str, Tuple[str, str], str]]) -> str:
    """

    :param combined_record_group: tuple of tuples - everything from both participants.
    :return: string of tuples separated by newlines - everything "cleaned". Excess coordinates and information removed.
    """

    result: str = ''

    for group in combined_record_group:
        treasure_1, _, treasure_2, coord_tuple, color = group
        result = result + "{}\n".format((treasure_1, treasure_2, coord_tuple, color))

    return result
