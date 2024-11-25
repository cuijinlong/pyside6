from PySide6.QtCore import QObject, Slot, Signal
from context.LoginUser import LoginUser

class LoginController(QObject):
    onLoggedIn = Signal(LoginUser)
    onLoggedOut = Signal()

    def __init__(self):
        super().__init__()
        self.currentUser = None

    @Slot(str, str, result=bool)
    def login(self, username, password):
        loginUser = LoginUser(username, password)
        if loginUser.isAuthenticated():
            self.currentUser = loginUser
            self.onLoggedIn.emit(loginUser)
            return True
        return False
    
    @Slot(result=LoginUser)
    def getCurrentUser(self):
        return self.currentUser
    
    @Slot()
    def logout(self):
        if self.currentUser:
            self.currentUser = None
            self.onLoggedOut.emit()
