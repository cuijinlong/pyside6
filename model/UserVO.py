from PySide6.QtCore import QObject, Property

class UserVO(QObject):
    def __init__(self, userName, six, age):
        super().__init__()
        self._userName = userName
        self._six = six
        self._age = age

    # 用户名 getter 方法
    @Property(str)
    def userName(self):
        return self._userName

    # 用户名 setter 方法
    @userName.setter
    def username(self, userName):
        self._userName = userName

    # 用户名 getter 方法
    @Property(str)
    def six(self):
        return self._six

    # 用户名 setter 方法
    @six.setter
    def six(self, six):
        self._six = six

    # 用户名 getter 方法
    @Property(int)
    def age(self):
        return self._age

    # 用户名 setter 方法
    @age.setter
    def age(self, age):
        self._age = age