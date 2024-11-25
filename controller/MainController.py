import os
from pathlib import Path
import sys
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication
from PySide6.QtCore import QUrl
from PySide6.QtQuick import QQuickView
from LoginController import LoginController
from HomeController import HomeController
from listener.LoginListener import LoginListener
from handler.MenuHandler import MenuHandler
from handler.UserHandler import UserHandler

class MainController(QQuickView):

    def __init__(self):
        super().__init__()
        self.setResizeMode(QQuickView.SizeRootObjectToView)
        self.viewPath = Path(__file__).resolve().parent.parent
        self.loginController = LoginController()
        self.menuHandler = MenuHandler()
        self.userHandler = UserHandler()
        self.loginListener = LoginListener(self)
        # {"userName": "张三", "six": "男", "age": 20}, 
        # {"userName": "李四", "six": "女", "age": 26}, 
        # {"userName": "王五", "six": "男", "age": 30} 
        self.loginController.onLoggedIn.connect(self.loginListener.doLogin)
        self.loginController.onLoggedOut.connect(self.loginListener.doLogout)
        self.rootContext().setContextProperty("loginController", self.loginController)
        self.rootContext().setContextProperty("menuHandler", self.menuHandler)
        self.rootContext().setContextProperty("userHandler", self.userHandler)
        # self.statusChanged.connect(self.onStatusChanged)     
            
    def showLoginView(self):
        loginQmlFile = os.fspath(self.viewPath / 'views/LoginView.qml')
        self.setSource(QUrl.fromLocalFile(loginQmlFile))
        self.show()

    def showHomeView(self):
        homeQmlFile = os.fspath(self.viewPath / 'views/HomeView.qml')
        self.setSource(QUrl.fromLocalFile(homeQmlFile))
        if self.status() == QQuickView.Status.Error:
            print("Error loading HomeView.qml:", self.errors())
        # if self.status() == QQuickView.Ready:
        #     self.rootContext().setContextProperty("userVoList", self.userVoList)
        self.show()

    def showComponentTestView(self):
        # qmlFile = os.fspath(self.viewPath / 'views/ComponentTest.qml')
        qmlFile = os.fspath(self.viewPath / 'views/TableViewTest.qml')
        self.setSource(QUrl.fromLocalFile(qmlFile))
        if self.status() == QQuickView.Status.Error:
            print("Error loading HomeView.qml:", self.errors())
        # if self.status() == QQuickView.Ready:
        #     self.rootContext().setContextProperty("userVoList", self.userVoList)
        self.show()

    # def onStatusChanged(self, status):
    #     if status == QQuickView.Ready:
    #         self.rootContext().setContextProperty("userVoList", self.userVoList)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    # mainView = MainController()
    # mainView.showLoginView()
    # mainView.showHomeView()
    # mainView.showComponentTestView()
    # rootObject = mainView.rootObject()
    # sys.exit(app.exec())
    engine = QQmlApplicationEngine()
    # 加载 QML 文件
    # engine.load('views/TableViewTest.qml')
    # engine.load('views/LayoutTest.qml')
    engine.load('views/HomeView.qml')
    # 检查 QML 是否成功加载
    if not engine.rootObjects():
        sys.exit(-1)

    # 运行应用程序
    sys.exit(app.exec())
