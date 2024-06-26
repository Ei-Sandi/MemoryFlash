import csv
import os
import sys
import random
import time

def main():
    while True:
        main_screen()
        action = input("")
        if action == "1":
            deck_name = input("Enter deck name: ").title()
            create(deck_name)
            while True:
                question = input("Enter question: ")
                answer = input ("Enter answer: ")
                insert_elements(deck_name, question, answer)
                activity = input ("Next/Done: ")
                if activity.strip().title() == "Next":
                    pass
                elif activity.strip().title() == "Done":
                    break
                else:
                    raise ValueError("Invalid input")
        elif action == "2":
            deck_list = list_decks()
            deck_name = input("Choose a deck to open: ").title()
            if check_deck(deck_name,deck_list):
                open_list = open_deck(deck_name)
                timer = int(input("How many seconds will you need to think answers?"))
                base = len(open_list)
                mark = revise(open_list,timer)
                print(f"Congrautulations! You have scored {mark}/{base}")
                time.sleep(3)
        elif action == "3":
            deck_list = list_decks()
            deck_name = input("Choose the deck you want to delete: ").title()
            conf = input(f"Are you sure you want to delete {deck_name} ? (Yes/No)").strip().title()
            if check_deck(deck_name,deck_list) and delete_confirmation(conf):
                delete(deck_list,deck_name)
        elif action == "4":
            sys.exit("See you again in next section.")
        else:
            raise ValueError("Enter a valid input(1,2,3,4) ")

def main_screen():
    print("Welcome to Flash Memory")
    print("-----------------------")
    print("Choose an action: ")
    print("1) Create New Deck\n2) Open Existing Deck\n3) Delete Deck\n4) Exit")

def create(deck_name):
    #saving deck name
    with open("decks/decks.csv", "a") as file:
        file.write(f"{deck_name}\n")
    #creating file

    with open(f"decks/{deck_name}.csv", "a") as file:
        writer = csv.DictWriter(file, fieldnames=["Question","Answer"])
        writer.writeheader()

def insert_elements(deck_name, question, answer):
    with open(f"decks/{deck_name}.csv", "a") as file:
        writer = csv.DictWriter(file, fieldnames=["Question","Answer"])
        writer.writerow({"Question": question, "Answer": answer})

def list_decks():
    #list name from decks
    deck_list = []
    with open("decks/decks.csv") as file:
        for line in file:
            print(line.rstrip())
            deck_list.append(line.rstrip().title())
    return deck_list

def check_deck(deck_name,deck_list):
    if deck_name.title() not in deck_list:
        raise ValueError("Deck name not found in deck list.")
    else:
        return True

def open_deck(deck_name):
    open_list = []
    with open(f"decks/{deck_name}.csv") as file:
        reader = csv.DictReader(file)
        for line in reader:
            open_list.append({"Question": line["Question"], "Answer": line["Answer"]})
    return open_list

def revise(open_list, timer):
    mark = 0
    while len(open_list)>0:
        chosen = random.choice(open_list)
        if chosen in open_list:
            print(f"Question: {chosen['Question']} ")
            time.sleep(1)
            print(f"Revealing answer in {timer} secs")
            time.sleep(timer)
            print(f"Answer: {chosen['Answer']}")
            correct = input ("Is your answer correct? (Yes/No): ")
            if correct.strip().title() == "Yes":
                mark +=1
            open_list.remove(chosen)
    return mark

def delete_confirmation(conf):
    if conf == "Yes":
        return True
    else:
        return False

def delete(deck_list,deck_name):
    #removing file_name from decks
    for name in deck_list:
        if name == deck_name:
            deck_list.remove(deck_name)
    #rewriting new list in decks
    with open("decks/decks.csv", "w") as file:
        for name in deck_list:
            file.write(f"{name}\n")
    #removing file
    os.remove(f"decks/{deck_name}.csv")

if __name__ == "__main__":
    main()
