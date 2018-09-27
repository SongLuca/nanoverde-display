import QtQuick 2.4
import QtQuick.Window 2.2
import QtQml 2.2

import nanodisplay 1.0

Window {
    id: window
    visible: true
    width: 480
    height: 272
    title: qsTr("Nanoverde-display")
    color: "light green"

    FileChecker {
        id: filechecker

        onNewTagUsername: {
            if (filechecker.tagUsername != "NULL" && filechecker.tagResult == "erogato") {
                beer.visible = true
                beerAnimation.running = true
                tagUser.visible = true
                tagUserScaling.running = true
            }
            else if (filechecker.tagUsername != "NULL" && filechecker.tagResult == "premio") {

            }
            else if (filechecker.tagUsername != "NULL" && filechecker.tagResult == "ore") {

            }
            else if (filechecker.tagUsername != "NULL" && filechecker.tagResult == "tag") {

            }
            else if (filechecker.tagUsername != "NULL" && filechecker.tagResult == "chiuso") {

            }

        }
    }

    Image {
        id: beer
        x: 99
        y: 99
        source: "images/cheers_90degrees.svg"
        width: 75
        height: 75
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false

        SequentialAnimation {
            id: beerAnimation
            running: false

            //Starting animation
            ParallelAnimation {
                ScaleAnimator {
                    target: beer
                    from: 0
                    to: 1
                    duration: 400
                }

                SequentialAnimation {
                    RotationAnimator {
                        target: beer
                        from: 0
                        to: 60
                        duration: 150
                    }

                    RotationAnimator {
                        target: beer
                        from: 60
                        to: -30
                        duration: 150
                    }

                    RotationAnimator {
                        target: beer
                        from: -30
                        to: 15
                        duration: 150
                    }

                    RotationAnimator {
                        target: beer
                        from: 15
                        to: 0
                        duration: 150
                    }
                }
            }

            PauseAnimation {
                duration: 3000
            }

            //Ending animation
            ScaleAnimator {
                target: beer
                from: 1
                to: 0
                duration: 200

            }
            onStopped: {
                beer.visible = false
                console.log(beer.visible)
                console.log("DNOSADJ")
            }
        }

    }

    Text {
        id: tagUser
        y: 272
        rotation: -90
        text: filechecker.tagUsername
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 20

        SequentialAnimation {
            id: tagUserScaling
            running: false

            //Starting animation
            ScaleAnimator {
                target: tagUser
                from: 0
                to: 1
                duration: 150
            }

            PauseAnimation {
                duration: 3000
            }

            //Ending animation
            ScaleAnimator {
                target: tagUser
                from: 1
                to: 0
                duration: 200
            }
            onStopped: {
                tagUser.visible = false
            }
        }
    }

    Text {
        id: status
        x: -107
        y: 118
        rotation: -90
        visible: true
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.bottomMargin: 118
        anchors.bottom: parent.bottom
        font.pixelSize: 30

    }

    Text {
        id: openTime
        x: 158
        y: 130
        rotation: -90
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        visible: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 130
    }

    Rectangle {
        id: rectangle
        x: -101
        width: 272
        height: 70
        anchors.verticalCenter: parent.verticalCenter
        visible: true
        color: "#B9F6CA"
        anchors.verticalCenterOffset: 0
        rotation: -90

        Text {
            text: "Date"
            visible: true
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }

        Text {
            id: date
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 30
            font.capitalization: Font.AllUppercase
        }

        Text {
            id: time
            x: 100
            y: 300
            anchors.rightMargin: 50
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 30
        }

        Item {
            id: item1
            Timer {
                id: timer
                interval: 100
                running: true
                repeat: true
                onTriggered: {
                    openTime.text = Qt.formatDateTime(nextOpening(), "dd  MMM yyyy");
                    date.text = Qt.formatDateTime(new Date(), "dd  MMM  yyyy");
                    time.text = Qt.formatDateTime(new Date(), "hh:mm:ss");
                    checkOpen();
                }

            }
        }

    }

    function checkOpen() {
        var date = new Date();
        if (date.getDay() == 5 && date.getHours() > 18) {
            status.text = "APERTO";
            status.color = "green";
        }
        else {
            status.text = "CHIUSO";
            status.color = "red";
        }
    }

    function nextOpening () {
        var missingDays = {
            //1 = monday, 2 = tuesday etc...
            1: 4,
            2: 3,
            3: 2,
            4: 1,
            5: 0,
            6: 6,
            7: 5
        };
        var date = new Date();
        date.setDate(date.getDate() + missingDays[date.getDay()]);
        return date;
    }

}

/*##^## Designer {
    D{i:20;anchors_height:70;anchors_width:272}
}
 ##^##*/
