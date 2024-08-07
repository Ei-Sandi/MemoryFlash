import sys
from PySide6.QtCore import QObject, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, QmlElement
import project
import random

QML_IMPORT_NAME = "io.qt.textproperties"
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_MINOR_VERSION = 0

@QmlElement
class Bridge(QObject):
    def __init__(self):
        super().__init__()
        self.deck_instance = None

    @Slot(str, result=str)
    def getDeckName(self,deck_name):
        self.deck_instance = Deck(deck_name)
        project.create(deck_name)
        return deck_name
    
    @Slot(str, str, result=str)
    def getElements(self, q, a):
        self.deck_instance.getElements(q, a)
        return "Elements added"
    
    @Slot(result=list)
    def displayDecks(self):
        deck_list = project.list_decks()
        return deck_list
    
    @Slot(str)
    def deleteDecks(self,deck_name):
        deck_list = self.displayDecks()
        project.delete(deck_list,deck_name)
        return None
    
    @Slot(str,int)
    def getOpenDecks(self,deck_name, timer):
        self.deck_instance = OpenDeck(deck_name,timer)

    @Slot(result=int)
    def getCountdown(self):
        timer = self.deck_instance.getCountdown()
        return timer

    @Slot(result=str)
    def getDeck(self):
        deck = self.deck_instance.getDeck()
        return deck
    
    @Slot(result=str)
    def getQuestion(self):
        question = self.deck_instance.getQuestion()
        return question

    @Slot(result=str)
    def getAnswer(self):
        answer = self.deck_instance.getAnswer()
        return answer 
    
    @Slot(result=bool)
    def getListEmpty(self):
        return self.deck_instance.listEmpty()
    
    @Slot(result=int)
    def addMark(self):
        mark = self.deck_instance.addMark()
        return mark 
    
    @Slot(result=int)
    def getMark(self):
        mark = self.deck_instance.getMark()
        return mark 
    
    @Slot(result=int)
    def getNum(self):
        num = self.deck_instance.getNum()
        return num 
    
class Deck():
    def __init__(self, deck_name):
        super().__init__()
        self.deck_name = deck_name

    def getElements(self,q,a):
        project.insert_elements(self.deck_name,q,a)
        return None
    
class OpenDeck():
    def __init__(self, deck_name, timer=10):
        super().__init__()
        self.deck_name = deck_name
        self.timer = timer
        self.chosen = "" 
        self.mark =0
        self.open_list = project.open_deck(self.deck_name)
        self.num = len(self.open_list)

    def getCountdown(self):
        return self.timer
    
    def getDeck(self):
        return self.deck_name
    
    def getQuestion(self):
        try:
            self.chosen = random.choice(self.open_list)
            self.open_list.remove(self.chosen)
            return self.chosen['Question']
        except IndexError:
            return "Exit"

    def getAnswer(self):
        return self.chosen['Answer']
    
    def listEmpty(self):
        if len(self.open_list) <1 :
            return True
        else:
            return False
    
    def addMark(self):
        self.mark +=1
        return self.mark

    def getMark(self):
        return self.mark
    
    def getNum(self):
        return self.num

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load("QML/main.qml")
    if not engine.rootObjects():
        sys.exit(-1)
    exit_code = app.exec()
    del engine
    sys.exit(exit_code)