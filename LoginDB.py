from tkinter import *
import executeSQL
from executeSQL import *

root = Tk()
root.title("Login")
width = 400
height = 280
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
x = (screen_width/2) - (width/2)
y = (screen_height/2) - (height/2)
root.geometry("%dx%d+%d+%d" % (width, height, x, y))
root.resizable(0, 0)


#==============================Methods========================================
def Login(event=None):
    global user_id

    connectDB,cursorDB = executeSQL.ConnectDataBase()

    if USERID.get() == "" or PASSWORD.get() == "":
        lbl_text.config(text="Please complete the required field!", fg="red")
    else:
        cursorDB.execute("SELECT * FROM playersignupinfo WHERE id = %s AND passwd = %s", (USERID.get(), PASSWORD.get()))
        if cursorDB.fetchone() is not None:
            user_id = USERID.get()
            HomeWindow()
            USERID.set("")
            PASSWORD.set("")
            lbl_text.config(text="")
        else:
            lbl_text.config(text="Invalid ID or Password", fg="red")
            USERID.set("")
            PASSWORD.set("") 

def HomeWindow():
    global Home
    root.withdraw()
    Home = Toplevel()
    Home.title("Login")
    width = 300
    height = 100
    screen_width = root.winfo_screenwidth()
    screen_height = root.winfo_screenheight()
    x = (screen_width/2) - (width/2)
    y = (screen_height/2) - (height/2)
    root.resizable(0, 0)
    Home.geometry("%dx%d+%d+%d" % (width, height, x, y))
    lbl_home = Label(Home, text="Successfully Login!", font=('arial', 20)).pack()
    btn_back = Button(Home, text='Close', command=Back).pack(pady=20, fill=X)

def Back():
    Home.destroy()
    root.destroy()
    
#==============================변수===========================================
USERID = StringVar()
PASSWORD = StringVar()
#==============================프레임=========================================
Top = Frame(root, bd=2,  relief=RIDGE)
Top.pack(side=TOP, fill=X)
Form = Frame(root, height=200)
Form.pack(side=TOP, pady=20)
#==============================라벨============================================
lbl_title = Label(Top, text = "Welcome To ALLISWELL", font=('arial', 15))
lbl_title.pack(fill=X)
lbl_userid = Label(Form, text = "ID:", font=('arial', 14), bd=15)
lbl_userid.grid(row=0, sticky="e")
lbl_password = Label(Form, text = "Password:", font=('arial', 14), bd=15)
lbl_password.grid(row=1, sticky="e")
lbl_text = Label(Form)
lbl_text.grid(row=2, columnspan=2)
#==============================입력창 프레임====================================
userid = Entry(Form, textvariable=USERID, font=(14))
userid.grid(row=0, column=1)
password = Entry(Form, textvariable=PASSWORD, show="*", font=(14))
password.grid(row=1, column=1)
userid.focus()
#==============================버튼 프레임=======================================
btn_login = Button(Form, text="Login", width=45, command=Login)
btn_login.grid(pady=25, row=3, columnspan=2)
btn_login.bind('<Return>', Login)

def login_function():
    root.mainloop()
    return user_id