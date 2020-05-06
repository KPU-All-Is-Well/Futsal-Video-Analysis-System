import tkinter as tk
from tkinter import ttk
import pymysql 

connect = pymysql.connect(host='15.164.30.158', user='sk', password='1234', db='AIWUserDB',charset='UTF8MB4')
cursor = connect.cursor()

sql_syntax="SELECT team FROM coachsignupinfo"

cursor.execute(sql_syntax)
connect.commit()

fetch_data=cursor.fetchall()

teamList=[]

for i in fetch_data:
    teamList.append(i[0])

def buttonOK_team():
    pickTeam.destroy()

def buttonOK_player():
    pickPlayer.destroy()


pickTeam = tk.Tk()
pickTeam.geometry('230x60+50+50')
pickTeam.title("Team")
pickTeam.resizable(0,0)

teamName = tk.StringVar()

labelTop = tk.Label(pickTeam, text ="Choose your Team")
labelTop.pack(anchor="center")
# labelTop.grid(column=0, row=0)

# sortedBox = ttk.Combobox(pickTeam, values=sortedList, sGtate="readonly")
# sortedBox.pack(side="left",padx=5)
teamBox = ttk.Combobox(pickTeam, height=10,width = 20, values=teamList, state="readonly",textvariable=teamName)
teamBox.pack(side="left",padx=5)
teamBox.current(0)
# comboExample.grid(column=0, row=1, ipadx=20)

okButton=tk.Button(pickTeam, width=5, command=buttonOK_team, repeatdelay=1000, repeatinterval=100, text="OK")
okButton.pack(side="left", padx=5)

pickTeam.mainloop()

myTeam = teamName.get()
print(myTeam)

sql_syntax='SELECT en_name FROM playersignupinfo WHERE team = "{0}"'.format(myTeam)

cursor.execute(sql_syntax)
fetch_data=cursor.fetchall()

playerList=[]

for i in fetch_data:
    playerList.append(i[0])

pickPlayer = tk.Tk() 
pickPlayer.geometry('230x60+50+50')
pickPlayer.title("Player")
pickPlayer.resizable(0,0)

playerName = tk.StringVar()

labelTop = tk.Label(pickPlayer, text ="Choose your Player")
labelTop.pack(anchor="center")
# labelTop.grid(column=0, row=0)

# sortedBox = ttk.Combobox(pickPlayer, values=sortedList, state="readonly")
# sortedBox.pack(side="left",padx=5)
playerBox = ttk.Combobox(pickPlayer, height=10,width = 20, values=playerList, state="readonly",textvariable=playerName)
playerBox.pack(side="left",padx=5)
# playerBox.current(0)
# comboExample.grid(column=0, row=1, ipadx=20)

okButton=tk.Button(pickPlayer, width=5, command=buttonOK_player, repeatdelay=1000, repeatinterval=100, text="OK")
okButton.pack(side="left", padx=5)

pickPlayer.mainloop()

myPlayer = playerName.get()
print(myPlayer)