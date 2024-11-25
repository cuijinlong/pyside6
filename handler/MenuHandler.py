from PySide6.QtCore import QObject, Slot, Signal

class MenuHandler(QObject):

    def __init__(self):
        super().__init__()

    @Slot()
    def openFile(self):
        print("11111")