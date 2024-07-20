# Flash Memory
#### Video demo: <https://www.youtube.com/watch?v=R2d2ZXP1dxw>
#### Description: A flash card application to assist your study needs.

##### Introduction
This application will allow you to create decks, open decks (and revise/study) and delete decks and assist in your memorization process.

##### How to
In main page, the user is prompted to choose from 4 actions; creating deck, opening deck, deleting deck and exiting application.
###### CREATING DECK
Choose option 1 from the main page to create a deck.
After chosing option 1,
- Enter name of the new deck
- Add question, add answer and choose Next/Done
- Next - to add more pairs of questions and answers.
- Done - to stop adding more pairs.
###### OPENING EXISTING DECK
Choose option 2 from the main page to open existing deck.
After chosing option 2,
- The names of existing decks will be listed
- Enter the name of the deck you want to open
- Enter timer needed to think an answer
- Question will be revealed first, followed by answer in your choice of time
- Choose whether you answer the answer correctly
- Your mark will be revealed once all the questions and answers are revealed
###### DELETING DECK
Choose option 3 from the main page to delete an existing deck.
After chosing option 3,
- The names of existing decks will be listed
- Enter the name of the deck you want to delete
- Confirm your choice
###### EXITING APP
Choose option 4 from the main page to exit the application.

##### Code Explanation
The application is written in project.py which includes all the codes required to fully function.

Upon choosing the creating deck function , the deck name will be stored in decks.csv file of decks folder and another csv file with the deck name will be created.
The decks.csv will store all the names of decks created.
The other csv files created with deck names will store questions and answers sets inputted in each of the decks respectively.

Upon choosing the opening deck function, all the deck names inside decks.csv will be listed and the user is required to choose one of the decks from the list. If the deck name of user requested doesn't exit in the list, an error message will be displayed.
The csv file created with user-requested deck name will be opened and user will be asked to enter a time to think the answer.
The questions will be asked in a random order.
The user will be asked to enter whether they answer the question correctly or not and marks will be displayed at the end.

Upon choosing the deleting deck function, all the decks name inside decks.csv will be listed and the user is required to choose one of the decks from the list. If the deck name of user requested doesn't exit in the list, an error message will be displayed.
A confirmation message will be displayed making sure the user actually want to delete this deck.
And finally the deck name will be removed from decks.csv file and the csv file with deck name will also be removed.

##### Testing

Libraries used - 

import csv

import os

import sys

import random

import time

You can download and run project.py and try out yourself. All the functions are already tested in test_project.py file by using pytest. Make sure you clean up your decks folder before trying out test_project.py.
