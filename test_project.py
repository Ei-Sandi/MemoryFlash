import pytest
import project as p
import csv
import os
from unittest.mock import patch

def test_create():
    p.create("Deck1")
    with open("decks/decks.csv", "r") as file:
        content = file.read()
        assert "Deck1" in content

    with open(f"decks/Deck1.csv", "r") as file:
        reader = csv.DictReader(file)
        assert reader.fieldnames == ["Question", "Answer"]

def test_insert_elements():
    p.insert_elements("Deck1", "Apple", "Red")
    with open(f"decks/Deck1.csv", "r") as file:
        reader = csv.DictReader(file)
        for row in reader:
            if row["Question"] == "Apple" and row["Answer"] == "Red":
                break
            else:
                assert False

def test_list_decks():
    with open("decks/decks.csv", "w") as file:
        file.write("Deck1\nDeck2\nDeck3\n")
    assert p.list_decks() == ["Deck1", "Deck2", "Deck3"]

def test_check_deck():
    with pytest.raises(ValueError):
        assert p.check_deck("Deck1",["Deck2"])
    assert p.check_deck("Deck1",["Deck1"]) == True

def test_open_deck():
    with open("decks/Deck1.csv", "w") as file:
        writer = csv.DictWriter(file, fieldnames=["Question", "Answer"])
        writer.writeheader()
        writer.writerow({"Question": "Q1", "Answer": "A1"})
        writer.writerow({"Question": "Q2", "Answer": "A2"})

    assert p.open_deck("Deck1") == [{"Question": "Q1", "Answer": "A1"}, {"Question": "Q2", "Answer": "A2"}]

def test_delete_confirmation():
    assert p.delete_confirmation("Yes") == True
    assert p.delete_confirmation("No") == False

def test_delete():
    with open("decks/decks.csv", "a") as file:
        file.write("Deck1\n")

    deck_list = p.list_decks()
    p.delete(deck_list,"Deck1")

    assert not os.path.exists("decks/Deck1.csv")

    with open("decks/decks.csv", "r") as file:
        assert "Deck1" not in file.read()

def test_revise():
    inputs = ['Yes', 'No']
    choices = [{'Question': 'Q1', 'Answer': 'A1'}, {'Question': 'Q2', 'Answer': 'A2'}]
    with patch('builtins.input', side_effect=inputs), patch('random.choice', side_effect=choices), patch('time.sleep'):
        mark = p.revise([{'Question': 'Q1', 'Answer': 'A1'}, {'Question': 'Q2', 'Answer': 'A2'}], 5)
        assert mark == 1
