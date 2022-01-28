""" Inventory Management module """

from typing import Dict, Tuple


def create_inventory(items: list[str]) -> Dict[str, int]:
    """

    :param items: list - list of items to create an inventory from.
    :return:  dict - the inventory dictionary.
    """

    return add_items({}, items)


def add_items(inventory: Dict[str, int], items: list[str]) -> Dict[str, int]:
    """

    :param inventory: dict - dictionary of existing inventory.
    :param items: list - list of items to update the inventory with.
    :return:  dict - the inventory dictionary update with the new items.
    """

    for item in items:
        inventory[item] = inventory.get(item, 0) + 1

    return inventory


def decrement_items(inventory: Dict[str, int], items: list[str]) -> Dict[str, int]:
    """

    :param inventory: dict - inventory dictionary.
    :param items: list - list of items to decrement from the inventory.
    :return:  dict - updated inventory dictionary with items decremented.
    """

    for item in items:
        if item in inventory and inventory[item] > 0:
            inventory[item] -= 1

    return inventory


def remove_item(inventory: Dict[str, int], item: str) -> Dict[str, int]:
    """
    :param inventory: dict - inventory dictionary.
    :param item: str - item to remove from the inventory.
    :return:  dict - updated inventory dictionary with item removed.
    """

    print(inventory, item)
    if item in inventory:
        del inventory[item]

    return inventory


def list_inventory(inventory: Dict[str, int]) -> list[Tuple[str, int]]:
    """

    :param inventory: dict - an inventory dictionary.
    :return: list of tuples - list of key, value pairs from the inventory dictionary.
    """

    result = []
    for (key, value) in inventory.items():
        if value > 0:
            result.append((key, value))

    return result
