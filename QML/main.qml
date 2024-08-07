import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Controls.Material

import io.qt.textproperties

ApplicationWindow {
    title: qsTr("MemoryFlash")
    width: 640
    height: 480
    visible: true

    Bridge {
        id: bridge
    }

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: "#332BC7" }
            GradientStop { position: 1; color: "#277F83" }
        }
    }

    Rectangle {
        id: header
        width: 640
        height: 180
        color: "transparent"

        Text {
            id: name
            text: "Memory Flash"
            font.family: "Trebuchet MS"
            font.pointSize: 28
            font.bold: true
            color: "#001C41"
            anchors.centerIn: parent
        }
        Text {
            text: "A flash card app to refresh your memory"
            font.family: "Trebuchet MS"
            font.pointSize: 12
            color: "#001C41"
            anchors.top: name.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 10
        }
    }

    StackView {
        id: stack
        anchors.top: header.bottom
        anchors.left: parent.left
        initialItem: mainView
    }

    Component{
        id: mainView

        Rectangle {
            width: 640
            height: 200
            color: "transparent"

            GridLayout {
                columns:1
                anchors.horizontalCenter: parent.horizontalCenter
                
                ButtonLabel{
                    id: btn_create
                    txt: "Create New Deck"
                    onClicked: stack.replace(createDecks)
                }
                Rectangle {
                    width: 140
                    height: 20
                    color: "transparent"
                }
                ButtonLabel{
                    id: btn_open
                    txt: "Open Existing Deck"
                    onClicked: stack.replace(openDecks)
                }
                Rectangle {
                    width: 140
                    height: 20
                    color: "transparent"
                }
                ButtonLabel{
                    id: btn_delete
                    txt: "Delete A Deck"
                    onClicked: stack.replace(deleteDecks)
                }
            }
        }
    }

    Component {
        id: createDecks

        Rectangle{
            width: 640
            height: 200
            color: "transparent"

            Row {
                id: row1
                spacing: 50
                leftPadding: 30
                topPadding: 50

                Text {
                    text: "Enter New Deck Name: "
                    font.pointSize: 12
                    topPadding: 8
                }
                TextField {
                    id: deckName
                    width: 200
                    height: 40
                    placeholderText: qsTr("Enter name")
                }
                ButtonLabel {
                    id: btn_submit
                    txt: "Create"
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 30
                        color: "transparent" 
                        border.color: "#003780"
                        border.width: btn_submit.hovered ? 2 : 1
                    }
                    onClicked: {
                        var deck = deckName.text
                        if (deck.length > 0) {
                            bridge.getDeckName(deck)
                            stack.replace(addElements)
                        } else {
                            console.log("Please enter a deck name.")
                        }
                    }   
                }
            }
            ButtonLabel {
                id: btn_main
                txt: "Return to Main Page"
                onClicked: stack.push(mainView)
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottom: parent.bottom

                background: Rectangle{
                    color: "transparent"
                    border.width: 0
                }
            }
        }
    } 

    Component {
        id: addElements

        Rectangle{
            id:textArea
            width: 640
            height: 230
            color: "transparent"

            Row{
                spacing: 50
                leftPadding: 150
                topPadding: 40
                Text {
                    text: "Question : "
                    font.pointSize: 12
                    topPadding: 10
                }
                TextField {
                        id: qText
                        width: 200
                        height: 40
                        placeholderText: qsTr("Enter question")
                }
            }
            Row {
                spacing: 50
                leftPadding: 150
                topPadding: 100
                Text {
                    text: "   Answer : "
                    font.pointSize: 12
                    topPadding: 10
                }
                TextField {
                        id: aText
                        width: 200
                        height: 40
                        placeholderText: qsTr("Enter answer")
                }
            }
            Rectangle {
                width: 640
                height: 100
                anchors.top: textArea.bottom
                color: "transparent"

                Row {
                    spacing: 50
                    leftPadding: 350

                    ButtonLabel {
                        id: btn_add
                        txt: "Add"
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 30
                            color: "transparent" 
                            border.color: "#003780"
                            border.width: btn_add.hovered ? 2 : 1
                        }
                        onClicked:{
                            var result = bridge.getElements(qText.text, aText.text)
                            console.log(result)
                        }
                    }
                    ButtonLabel {
                        id: btn_done
                        txt: "Done"
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 30
                            color: "transparent" 
                            border.color: "#003780"
                            border.width: btn_done.hovered ? 2 : 1
                        }
                        onClicked:{
                            stack.replace(mainView)
                        }
                    }
                }   
            }   
        }
    }  

    Component {
        id: openDecks
            Rectangle{
                id: listDecks
                width: 640
                height: 230
                color: "transparent"

                ListModel {
                    id: deckListModel
                }

                property alias deckList: deckListModel
                property string chosen: ""
                property int countdown: 0

                Component.onCompleted: {
                    var deckList = bridge.displayDecks()
                    deckListModel.clear()
                    for (var i = 0; i < deckList.length; i++) {
                        deckListModel.append({"name": deckList[i]})
                    }
                }
                
                ButtonGroup { id: radioGroup }
                
                Text {
                    id: label
                    text: "Choose a deck to open: "
                    font.pointSize: 12
                    leftPadding: 30
                    topPadding: 5
                }
                Rectangle{
                    id: openMain
                    width: 640
                    height: 100
                    color: "transparent"
                    anchors.top: label.bottom

                    GridLayout {
                    id: rButtons
                    columns: 4
                    anchors.centerIn: parent

                        Repeater {
                            model: deckListModel
                            delegate: RadioButton {
                                text: model.name
                                ButtonGroup.group: radioGroup
                                onClicked: {
                                    chosen = model.name;
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    id: timer
                    width: 640
                    height: 50
                    anchors.bottom: openButtons.top
                    color: "transparent"
                    Row {
                        spacing: 20
                        bottomPadding: 20
                        Text {
                            text: "Enter number of seconds to think answers"
                            font.pointSize: 11
                            leftPadding: 30
                            topPadding: 5
                            bottomPadding: 8
                        }
                        TextField {
                            id: timertxt
                            height: 40
                            width: 60
                        }   
                    }
                }
                Rectangle {
                    id: openButtons
                    width: 640
                    height: 30
                    anchors.top: listDecks.bottom
                    color: "transparent"

                    Row {
                        spacing: 50
                        topPadding: 10
                        leftPadding: 350
                        
                        ButtonLabel {
                            id: btn_open
                            txt: "Open"
                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 30
                                color: "transparent" 
                                border.color: "#003780"
                                border.width: btn_open.hovered ? 2 : 1
                            }
                            onClicked:{
                                if (chosen){
                                    countdown = parseInt(timertxt.text)
                                    bridge.getOpenDecks(chosen,countdown)
                                    stack.replace(revise)
                                } else {
                                    console.log("Choose a deck to open")
                                }
                            }
                        }
                        ButtonLabel {
                            id: btn_back
                            txt: "Back"
                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 30
                                color: "transparent" 
                                border.color: "#003780"
                                border.width: btn_back.hovered ? 2 : 1
                            }
                            onClicked:{
                                stack.replace(mainView)
                            }
                        }
                }
            }
        }
    }

    Component {
        id: revise

        Rectangle{
            property int countdown: 0
            property string deck_name: ""
            property string question: ""
            property string answer: ""
            property int mark: 0
            property int total: 0

            Rectangle {
                id: head
                width: 640
                height: 50
                color: "transparent"
                Component.onCompleted: {
                    countdown= bridge.getCountdown()
                    deck_name= bridge.getDeck()
                    question= bridge.getQuestion()
                    answer= bridge.getAnswer()
                    mark = bridge.getMark()
                    total = bridge.getNum()
                    countdownTimer.start()
                }

                Row {
                    id: nav
                    spacing: 50
                    Text {
                        id: deck_name_txt
                        text: "Deck: " + deck_name
                        font.pointSize: 12
                        leftPadding: 50
                    }
                    Timer {
                        id: countdownTimer
                        interval: 1000  // 1 second
                        running: true
                        repeat: true
                        onTriggered: {
                            if (countdown > 0) {
                                countdown--
                            } else {
                                countdownTimer.stop()
                            }
                        }
                    }
                    Text {
                        text: + countdown > 0 ? "Revealing answer in "+countdown.toString() : "Time's up!"
                        font.pointSize: 12
                    }
                    Text {
                        text: "Score: " + mark + "/" + total
                        font.pointSize: 12
                    }
                }

                Rectangle {
                    id: rc_q
                    width: 640
                    height: 50
                    color: "transparent"
                    anchors.top: head.bottom
                    Row {
                        Text {
                            text: "Question = " + question
                            font.pointSize: 12
                            leftPadding: 50
                        }
                    }
                }
                Rectangle {
                    id: rc_a
                    width: 640
                    height: 50
                    color: "transparent"
                    anchors.top: rc_q.bottom
                    Row {
                        Text {
                            text: countdown > 0 ? " " : "Answer = "+answer
                            font.pointSize: 12
                            leftPadding: 50
                        }
                    }
                }
                Rectangle {
                    id: result
                    width: 640
                    height: 50
                    color: "transparent"
                    anchors.top: rc_a.bottom
                    Row {
                        spacing: 30
                        visible: countdown == 0
                        Text {
                            text: countdown > 0 ? " " : "Is your answer correct ?" 
                            font.pointSize: 12
                            topPadding: 8
                            leftPadding: 50
                            rightPadding: 100
                        }
                        ButtonLabel {
                            id: btn_yes
                            txt: "Yes"
                            enabled: countdown == 0
                            width: 50
                            onClicked: {
                                bridge.addMark()
                                if (bridge.getListEmpty()){
                                    stack.replace(reveal)
                                } else {
                                    stack.replace(revise)
                                }
                            }
                        }
                        ButtonLabel {
                            id: btn_no
                            txt: "No"
                            enabled: countdown == 0
                            width: 50
                            onClicked: {
                                if (bridge.getListEmpty()){
                                    stack.replace(reveal)
                                } else {
                                    stack.replace(revise)
                                }
                            }
                        }
                    }
                    
                } 
            }
        }
    }

    Component{
        id: reveal
        Rectangle{
            Rectangle {
                id: con_txt
                width: 640
                height: 230
                color: "transparent"

                Text{
                    text: "Congratulations ! Your Final Marks Are " + bridge.getMark() + "/" + bridge.getNum()
                    font.pointSize: 16
                    bottomPadding: 50
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                width: 640
                height: 100
                color: "transparent"
                anchors.top : con_txt.bottom

                ButtonLabel {
                    id: btn_mainn
                    txt: "Back to main menu"
                    anchors.horizontalCenter: parent.horizontalCenter
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 30
                        color: "transparent" 
                        border.color: "#003780"
                        border.width: btn_mainn.hovered ? 2 : 1
                    }
                    onClicked:{
                        stack.replace(mainView)
                    }
                }
            }
        }
    }

    Component {
        id: deleteDecks

        Rectangle{
            id: listDecks
            width: 640
            height: 230
            color: "transparent"

            ListModel {
                id: deckListModel
            }

            property alias deckList: deckListModel
            property string chosen: ""

            Component.onCompleted: {
                var deckList = bridge.displayDecks()
                deckListModel.clear()
                for (var i = 0; i < deckList.length; i++) {
                    deckListModel.append({"name": deckList[i]})
                }
            }
            
            ButtonGroup { id: radioGroup }
            
            Text {
                id: label
                text: "Choose a deck to delete: "
                font.pointSize: 12
                leftPadding: 30
                topPadding: 5
                bottomPadding: 10
            }
            Rectangle{
                width: 640
                height: 100
                color: "transparent"
                anchors.top: label.bottom

                GridLayout {
                id: rButtons
                columns: 4
                anchors.centerIn: parent

                    Repeater {
                        model: deckListModel
                        delegate: RadioButton {
                            text: model.name
                            ButtonGroup.group: radioGroup
                            onClicked: {
                                chosen = model.name;
                            }
                        }
                    }
                }
            }
            Rectangle {
                width: 640
                height: 100
                anchors.top: listDecks.bottom
                color: "transparent"

                Row {
                    spacing: 50
                    leftPadding: 350
                    
                    ButtonLabel {
                        id: btn_delete
                        txt: "Delete"
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 30
                            color: "transparent" 
                            border.color: "#003780"
                            border.width: btn_delete.hovered ? 2 : 1
                        }
                        onClicked:{
                            if (chosen){
                                bridge.deleteDecks(chosen)
                                console.log("Successfully Deleted.")
                                stack.replace(mainView)
                            } else {
                                console.log("Choose a deck to delete")
                            }
                        }
                    }
                    ButtonLabel {
                        id: btn_back
                        txt: "Back"
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 30
                            color: "transparent" 
                            border.color: "#003780"
                            border.width: btn_back.hovered ? 2 : 1
                        }
                        onClicked:{
                            stack.replace(mainView)
                        }
                    }
                }
            }
        }
    }
}