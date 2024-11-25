from PySide6.QtCore import QObject, Slot, Signal
from model.UserVO import UserVO

class UserHandler(QObject):

    def __init__(self):
        super().__init__()

    @Slot(result=list)
    def getUserList(self):
        userVoList = []
        userVoList.append(UserVO("张三", "男",  20))
        userVoList.append(UserVO("李四", "女",  26))
        userVoList.append(UserVO("王五", "男",  30))
        return [
                {"userName": "张三", "six": "男", "age": 20}, 
                {"userName": "李四", "six": "女", "age": 26}, 
                {"userName": "王五", "six": "男", "age": 30}
               ]
    
