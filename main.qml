import QtQuick 2.11
import QtQuick.Window 2.11
import QtQml 2.2

import nanodisplay 1.0

Window {
    id: window
    visible: true
    width: 272
    height: 480
    title: qsTr("Nanoverde-display")
    color: "light green"

    FileChecker {
        id: filechecker
        onNewTagUsername: {
            beer.visible = true
            beerAnimation.running = true
            tagUser.visible = true
            tagUserScaling.running = true
        }
    }

    Image {
        id: beer
        x: 99
        y: 145
        source: "images/cheers.svg"
        width: 75
        height: 75
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false

        ParallelAnimation {
            id: beerAnimation
            running: false

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
    }

    Text {
        id: tagUser
        y: 237
        text: filechecker.tagUsername
        anchors.horizontalCenterOffset: 0
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 20

        ScaleAnimator {
            id: tagUserScaling
            running: false
            target: tagUser
            from: 0
            to: 1
            duration: 150
        }
    }

    Text {
        id: status
        visible: true
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.bottomMargin: 160
        anchors.bottom: parent.bottom
        font.pixelSize: 30

    }

    Text {
        id: openTime
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        visible: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
    }

    Rectangle {
        id: rectangle
        x: 463
        visible: true
        width: parent.width
        height: 70
        color: "#B9F6CA"
        transformOrigin: Item.Center
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

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
