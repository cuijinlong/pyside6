from PySide6.QtCore import QObject, Property

class LoginUser(QObject):

    def __init__(self, username, password):
        super().__init__()
        self._username = username
        self._password = password  # 注意：实际应用中不应以明文形式存储密码

    # 用户名 getter 方法
    @Property(str)
    def username(self):
        return self._username

    # 用户名 setter 方法
    @username.setter
    def username(self, username):
        self._username = username

    def isAuthenticated(self):
        if self._username == "1" and self._password == "1":
            return True
        else:
            return False