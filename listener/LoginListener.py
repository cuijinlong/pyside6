from PySide6.QtCore import QObject, QTimer
from context.LoginUser import LoginUser

class LoginListener(QObject):
    def __init__(self, mainController):
        super().__init__()
        self.mainController = mainController

    def doLogin(self, loginUser: LoginUser):
        print("doLogin")
        QTimer.singleShot(800, self.mainController.showHomeView)

    def doLogout(self):
        print("doLogout")
        QTimer.singleShot(800, self.mainController.showLoginView)
        