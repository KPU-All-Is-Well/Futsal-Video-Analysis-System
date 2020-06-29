import tkinter as tk
from tkinter import ttk
import pymysql

class PlayerNumber:
    def __init__(self):
        self.input_info = tk.Tk()
        self.input_info.geometry('250x120+50+50')
        self.input_info.title("Team")
        self.input_info.resizable(0,0)

        self.label_text=tk.Label(self.input_info,text="Select the number of player")
        self.label_text.grid(row=0, column=1,pady=5)

        self.label_home = tk.Label(self.input_info, text ="HOME")
        self.label_home.grid(row=1 , column=0,padx=5)
        self.label_away = tk.Label(self.input_info, text ="AWAY")
        self.label_away.grid(row=2 , column=0,padx=5)

        self.number_list=[0,1,2,3,4,5,6]

        self.home_player=tk.StringVar()
        self.away_player=tk.StringVar()

        self.home_box = ttk.Combobox(self.input_info, height=10,width = 20, values=self.number_list, state="readonly",textvariable=self.home_player)
        self.home_box.grid(row=1, column=1,padx=5)
        self.home_box.current(0)
        self.away_box = ttk.Combobox(self.input_info, height=10,width = 20, values=self.number_list, state="readonly",textvariable=self.away_player)
        self.away_box.grid(row=2, column=1,padx=5)
        self.away_box.current(0)

        self.okButton=tk.Button(self.input_info, width=10, command=self.button_event, repeatdelay=1000, repeatinterval=100, text="SUBMIT")
        self.okButton.grid(row=3 , column=1,pady=10)

        self.input_info.mainloop()

        self.home_int=int(self.home_player.get())
        self.away_int=int(self.away_player.get())

    def button_event(self):
        self.input_info.destroy()

class PlayerSelect:
    def __init__(self):
        # print("객체 생성") # Test Line 1
        ### 연결 MySQL 과 Tkinter GUI
        self.connect = pymysql.connect(host='15.164.30.158', user='sk', password='1234', db='AIWUserDB',charset='UTF8MB4')
        self.cursor = self.connect.cursor()

        self.sql_syntax="SELECT team FROM coachsignupinfo"

        self.cursor.execute(self.sql_syntax)
        self.connect.commit()

        self.fetch_data=self.cursor.fetchall()
        
        self.team_list=[]

        for self.i in self.fetch_data:
            self.team_list.append(self.i[0])

        self.selected_team = self.team_combobox()
        # print("TEST 1 "+self.selected_team) # Test Line 2

        self.sql_syntax='SELECT en_name FROM playersignupinfo WHERE team = "{0}"'.format(self.selected_team)

        self.cursor.execute(self.sql_syntax)
        self.fetch_data=self.cursor.fetchall()

        self.player_list=[]

        for self.i in self.fetch_data:
            self.player_list.append(self.i[0])

        self.selected_player = self.player_combobox()
        # print("TEST 2 "+self.selected_player) # Test Line 3
        
    def __del__(self):
        print('PlayerSelect 객체 소멸자 호출 \n')

    def buttonOK_team(self):
        self.pickTeam.destroy() #pickTeam
        print('destroy 함')
        
    def buttonOK_player(self):
        self.pickPlayer.destroy()
        
        
    def team_combobox(self):
        self.pickTeam = tk.Tk()
        self.pickTeam.geometry('230x60+50+50')
        self.pickTeam.title("Team")
        self.pickTeam.resizable(0,0)

        self.team_name = tk.StringVar()

        self.top_label = tk.Label(self.pickTeam, text ="Choose your Team")
        self.top_label.pack(anchor="w",padx=5,pady=5)

        self.team_box = ttk.Combobox(self.pickTeam, height=10,width = 20, values=self.team_list, state="readonly",textvariable=self.team_name)
        self.team_box.pack(side="left",padx=5)
        self.team_box.current(0)

        self.button_ok=tk.Button(self.pickTeam, width=5, command=self.buttonOK_team, repeatdelay=1000, repeatinterval=100, text="OK")
        self.button_ok.pack(side="left", padx=5)
        
        print('before team_combobox \n')
        self.pickTeam.mainloop() #### 여기가 이상함. 원래 팀 선택한 다음에 선수 선택하는 창이 떠야 하는데 안 뜸. 
        print('after team_combobox \n')
        
        return self.team_name.get()
    
    def player_combobox(self):
        self.pickPlayer = tk.Tk() 
        self.pickPlayer.geometry('230x60+50+50')
        self.pickPlayer.title("Player")
        self.pickPlayer.resizable(0,0)

        self.player_name = tk.StringVar()

        self.top_label = tk.Label(self.pickPlayer, text ="Choose your Player")
        self.top_label.pack(anchor="w",padx=5,pady=5)

        self.player_box = ttk.Combobox(self.pickPlayer, height=10,width = 20, values=self.player_list, state="readonly",textvariable=self.player_name)
        self.player_box.pack(side="left",padx=5)
        self.player_box.current(0)

        self.button_ok=tk.Button(self.pickPlayer, width=5, command=self.buttonOK_player, repeatdelay=1000, repeatinterval=100, text="OK")
        self.button_ok.pack(side="left", padx=5)

        print('before player_combobox \n')
        self.pickPlayer.mainloop()
        print('after player_combobox \n')
        
        return self.player_name.get()


#player_number=PlayerNumber()
#print(player_number.home_int, player_number.away_int)

#player=PlayerSelect()
#print(player.selected_team , player.selected_player)
