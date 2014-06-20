import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import GLWindow 1.0

ApplicationWindow {
    id: root;
    width: 800;
    height: 600;
    visible: true;
    visibility: "FullScreen";

    GLWindow {
        id: glWindow;
        libcore: "../bsnes_balanced_libretro.dll";
        game: "";
        run: true;

        // Eventually have GLWindow not load anything on creation
        // Will run when core and game paths have been entered through
        // qml.

        // Each core could be it's own qml class/type, would allow easy
        // extending through qml and keep it so we wouldn't need to
        // touch c++ side. Just an idea.

        // Also keep last used core loaded on
        // frontend startup. Will hopefully reduce load time of game.
    }

    Rectangle {
        id: bubbleMenu;
        visible: false;
        width: 200;
        height: 300;
        color: "#5a5a5a";
        opacity: 0.3;
        anchors {
            bottom: rect.top;
            left: parent.left;
            leftMargin: 10;
            bottomMargin: 10;
        }

    }

    Rectangle {
        id: rect;
        anchors {
            left: parent.left
            right: parent.right;
            bottom: parent.bottom;
            margins: 20;
        }

        height: 35;
        color: "#353434";
        radius: 4
        //border.width: 1
        //border.color: "white"

        Item {
            anchors {
                left: parent.left;
                right: parent.right;
                top: parent.top;
                bottom: parent.bottom;
                leftMargin: 6;
            }

            Row {
                anchors {
                    left: parent.left;
                    top: parent.top;
                    bottom: parent.bottom;
                }
                width: 200;
                spacing: 20;

                Button {
                    id: settingsBtn;
                    anchors.verticalCenter: parent.verticalCenter;
                    onClicked: bubbleMenu.visible ? bubbleMenu.visible = false : bubbleMenu.visible = true;
                    style: ButtonStyle {
                        background: Image {
                            source: "assets/navicon-round.png";
                            sourceSize.width: 20;
                            sourceSize.height: 20;
                        }
                    }
                }
                Button {
                    id: quitBtn;
                    anchors.verticalCenter: parent.verticalCenter;
                    style: ButtonStyle {
                        background: Image {
                            source: "assets/power.png";
                            sourceSize.width: 20;
                            sourceSize.height: 20;
                        }
                    }
                    onClicked: Qt.quit(0);
                }

                Button {
                    id: play;
                    property string iconImage: "assets/play.png";
                    anchors.verticalCenter: parent.verticalCenter;
                    style: ButtonStyle {
                        background: Image {
                            source: play.iconImage;
                            sourceSize.width: 20;
                            sourceSize.height: 20;
                        }
                    }
                    onClicked:  {
                        if (glWindow.run) {
                            glWindow.run = false
                            play.iconImage = "assets/pause.png";
                        }
                        else {
                            glWindow.run = true;
                            play.iconImage = "assets/play.png";
                        }
                    }

                }
            }

            Row {
                anchors {
                    right: parent.right;
                    rightMargin: 50;
                    verticalCenter: parent.verticalCenter;
                }
                spacing: 60;

                Button {
                    id: qualityBtn;
                    anchors.verticalCenter: parent.verticalCenter;
                    style: ButtonStyle {
                        background: Image {
                            source: "assets/gear-a.png";
                            sourceSize.width: 25;
                            sourceSize.height: 25;
                        }
                    }
                }

                Button {
                    id: favoriteBtn;
                    style: ButtonStyle {
                        background: Image {
                            source: "assets/star.png";
                            sourceSize.width: 25;
                            sourceSize.height: 25;
                        }
                    }
                }

                Button {
                    id: resizeBtn;
                    onClicked: root.visibility = "Windowed";
                    anchors.verticalCenter: parent.verticalCenter;
                    style: ButtonStyle {
                        background: Image {
                            source: "assets/arrow-expand.png";
                            sourceSize.width: 25;
                            sourceSize.height: 25;
                        }
                    }

                }
            }

        }

    }
}
