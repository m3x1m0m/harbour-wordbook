import QtQuick 2.0
import Sailfish.Silica 1.0
import com.dictcc 1.0

Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: parent.height
        SilicaListView {
            anchors.fill: parent
            spacing: Theme.paddingMedium
            model: DictModel {
                id: dict_model
            }
            header: Column {
                PullDownMenu {
                    MenuItem {
                        text: "DEEN"
                        onClicked: dict_model.change_language("DEEN")
                    }
                    MenuItem {
                        text: "DESV"
                        onClicked: dict_model.change_language("DESV")
                    }
                    MenuItem {
                        text: "DENL"
                        onClicked: dict_model.change_language("DENL")
                    }
                    MenuItem {
                        text: "About"
                        onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
                    }
                }
                PageHeader {
                    title: "Dictcc"
                }
                width: page.width
                SearchField {
                    width: page.width
                    id: user_input
                    placeholderText: qsTr("Enter word or phrase")
                    EnterKey.onClicked: {
                        dict_model.search(user_input.text)
                    }
                }
                GlassItem {
                    id: effect
                    height: Theme.paddingLarge
                    width: page.width
                    color: Theme.highlightColor
                    cache: false
                }
            }

            delegate: Column {
                width: page.width
                Label {
                    id: body
                    text: msg2usr
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeLarge
                    wrapMode: Text.WordWrap
                    //maximumLineCount: 3
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: Theme.paddingMedium
                        rightMargin: Theme.paddingMedium
                    }
                }
                Label {
                    wrapMode: Text.WordWrap
                    text: lang1
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                    font.pixelSize: Theme.fontSizeLarge
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: Theme.paddingMedium
                        rightMargin: Theme.paddingMedium
                    }
                }
                Label {
                    wrapMode: Text.WordWrap
                    text: lang2
                    color: Theme.primaryColor
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: Theme.paddingMedium
                        rightMargin: Theme.paddingMedium
                    }
                }
            }
        }
    }
}


