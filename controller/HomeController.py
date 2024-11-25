import os
from pathlib import Path
import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtCore import QUrl, QObject, Slot
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuick import QQuickPaintedItem, QQuickView

class HomeController(QObject):

    def __init__(self):
        super().__init__()