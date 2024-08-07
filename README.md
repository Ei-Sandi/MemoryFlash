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

##### Testing
Libraries used - 
csv, os, sys, random, time
Pyside6, QtQuick

##### User Interface
Created user interface for more user friendly version. Run interface.py and try it out. 

You can download and run project.py and try out yourself. All the functions are already tested in test_project.py file by using pytest. Make sure you clean up your decks folder before trying out test_project.py.
