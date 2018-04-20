import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property string mail_addr: "stiefel.maximilian@online.de"
    id: page
    Column {
        id: col
        spacing: Theme.paddingLarge
        width: parent.width
        PageHeader {
            title: "About"
        }
        SectionHeader {
            text: "Powered By"
        }
        Label {
            text: "www.dict.cc"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        SectionHeader {
            text: "Author"
        }
        Label {
            text: "Maximilian Stiefel"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        GlassItem {
            id: seperator
            height: Theme.paddingLarge
            width: page.width
            color: Theme.highlightColor
            cache: false
        }
        Label {
            id: body
            text: "If you have feedback, bug reports or feature requests, just klick on the mail address below."
            font.pixelSize: Theme.fontSizeExtraSmall
            wrapMode: Text.WordWrap
            maximumLineCount: 3
            truncationMode: TruncationMode.Fade
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Theme.paddingMedium
                rightMargin: Theme.paddingMedium
            }
        }
        Label {
            text: mail_addr
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.highlightColor
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                id : buttonMouseArea
                anchors.fill : parent
                onClicked: Qt.openUrlExternally("mailto:" + mail_addr + "?subject=About Your Dictcc Sailfish OS App")
            }
        }
    }
}
