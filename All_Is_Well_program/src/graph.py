from matplotlib import pyplot as plt

#fig=plt.figure()

is_window_open = False
fig1=None

"""
def init_figure() :
    fig=plt.figure()
    wm = plt.get_current_fig_manager()
    wm.window.wm_geometry("920x500+1000+0")
    plt.close(fig)
"""

def draw_graph(time, speed, move_ratio, playername) :
    global is_window_open
    global fig1

    if (is_window_open == False) :
        is_window_open = True
        fig1=plt.figure(1)
        #fig=plt.figure(figsize=(9,4.2))
        #fig.canvas.manager.window.Move(1000,0)
        #wm = plt.get_current_fig_manager()
        #wm.window.wm_geometry("920x500+1000+0")
        
    plt.subplot(1,2,1) # plt.subplot(2,1,1) 세로
    plt.ion() # 대화형 모드 켬
    plt.plot(time, speed,linewidth=1,color='dodgerblue')
    mngr = plt.get_current_fig_manager()
    mngr.window.setGeometry(1011,38,920, 503)

    plt.xlabel('Play Time(sec)',fontsize=10)
    plt.ylabel('Speed(km/h)',fontsize=10)
    plt.title(playername+'\'s speed in the game',fontsize=10)
    plt.grid(True)
    
    #plt.legend([name + '\'s speed'])
    #speed_ratio = [50.2,40.3,9.5]
    labels = 'walk', 'jog', 'splint'
    colors= "#f5f5dc", "#a5ea89", "#6ccad0"
    
    
    ax=plt.subplot(1,2,2) # ax=plt.subplot(2,1,2) 세로
    ax.clear()
    plt.title(playername+'\'s speed ratio in the game',fontsize=10)
    pie=plt.pie(move_ratio, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, startangle=90)
    
    ## 원에 퍼센트 보이게 확장 pie=plt.pie(move_ratio, labels=labels, colors=colors, autopct='%1.1f%%', shadow=False, startangle=90, pctdistance = 0.85, explode = (0.05,0.05,0.05))
    
    #pie=plt.pie(move_ratio, colors=colors, shadow=False, startangle=90)
    
    plt.legend(pie[0],labels,loc='lower right')
    #fig.canvas.draw()
    #fig.canvas.flush_events()
    # 라벨 텍스트 겹침현상 해결하는방법
    #draw circle
    #centre_circle = plt.Circle((0,0),0.70,fc='white')
    #fig = plt.gcf()
    #fig.gca().add_artist(centre_circle)
    
    #실험용 추가
    plt.axis('equal')
    
    plt.tight_layout()
    plt.subplots_adjust(left=0.125,
                    bottom=0.1, 
                    right=0.9, 
                    top=0.9, 
                    wspace=0.2, 
                    hspace=0.35)
    


    
    plt.show()
    
def draw_ballshare_contribution(home_team, away_team, ball_share_A_res, ball_share_B_res, home_en_name_list, home_contribution_rate_list, away_en_name_list, away_contribution_rate_list) :
    # 공 점유율 그래프 
    fig2 = plt.figure(2)
    mngr = plt.get_current_fig_manager()
    mngr.window.setGeometry(600,50,520, 460) #x좌표, y좌표, 가로, 세로
    labels = home_team, away_team
    legends = home_team+' \'s Ball Possession', away_team+' \'s Ball Possession'
    colors= 'lightcoral', 'lightskyblue'
    explode = (0.05, 0.05)
    ball_possession= [ball_share_A_res, ball_share_B_res]
    
    plt.title('Ball possession in the game',fontsize=15,  fontweight= 'bold')
    pie=plt.pie(ball_possession, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, explode=explode, startangle=90, textprops={'fontsize': 11,'fontweight':'bold'})
    #plt.legend(pie[0],legends,loc='lower right')
    plt.legend(pie[0],legends)
    plt.axis('equal')
    


    # home team 선수 기여도 그래프  
    fig3=plt.figure(3)
    mngr = plt.get_current_fig_manager()
    mngr.window.setGeometry(150,500,870, 470)
    color='lightcoral'
    plt.title(home_team+' team member\'s contribution\n', fontsize=15,  fontweight= 'bold')
    
    plt.bar(home_en_name_list, home_contribution_rate_list, color=color, width=0.5, align='center')
    #plt.axis('equal')
    
    plt.xlim(-1,len(home_en_name_list))
    plt.ylim(0,100)
    plt.xlabel('Member Name')
    plt.ylabel('Member Contribution')
    
    for i,v in enumerate(home_en_name_list):
        str_val= str(home_contribution_rate_list[i])+' %'
        plt.text(v,home_contribution_rate_list[i],str_val,fontsize=10,horizontalalignment='center',verticalalignment='bottom')
    
    
    # away team 선수 기여도 그래프
    fig4=plt.figure(4)
    mngr = plt.get_current_fig_manager()
    mngr.window.setGeometry(1000,500,870, 470)    
    color='lightskyblue'    
    plt.title(away_team+' team member\'s contribution\n', fontsize=15,  fontweight= 'bold')
    
    plt.bar(away_en_name_list, away_contribution_rate_list, color=color, width=0.5, align='center')
    #plt.axis('equal')
    
    plt.xlim(-1,len(away_en_name_list))
    plt.ylim(0,100)
    plt.xlabel('Member Name')
    plt.ylabel('Member Contribution')
    
    for i,v in enumerate(away_en_name_list):
        str_val= str(away_contribution_rate_list[i])+' %'
        plt.text(v,away_contribution_rate_list[i],str_val,fontsize=10,horizontalalignment='center',verticalalignment='bottom')
   
    #그래프 3개 동시에 그려주기
    plt.ioff()
    plt.show()



def destroy_graph() :
    global fig1
    is_window_open = False
    plt.clf()
    plt.close(fig1)   
    plt.close()
    

