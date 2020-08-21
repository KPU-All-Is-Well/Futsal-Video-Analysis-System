from matplotlib import pyplot as plt

#fig=plt.figure()

is_window_open = False
fig=None

"""
def init_figure() :
    fig=plt.figure()
    wm = plt.get_current_fig_manager()
    wm.window.wm_geometry("920x500+1000+0")
    plt.close(fig)
"""

def draw_graph(time, speed, move_ratio, playername) :
    global is_window_open
    global fig

    if (is_window_open == False) :
        is_window_open = True
        fig=plt.figure()
        #fig=plt.figure(figsize=(9,4.2))
        #fig.canvas.manager.window.Move(1000,0)
        #wm = plt.get_current_fig_manager()
        #wm.window.wm_geometry("920x500+1000+0")
        
    plt.subplot(1,2,1) # plt.subplot(2,1,1) 세로
    plt.ion()
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

def draw_ballshare_graph(home_team, away_team, ball_share_A_res, ball_share_B_res) :
    
    labels = home_team, away_team
    legends = home_team+' \'s Ball Possession', away_team+' \'s Ball Possession'
    colors= 'lightcoral', 'lightskyblue'
    explode = (0.05, 0.05)
    ball_possession= [ball_share_A_res, ball_share_B_res]
    
    plt.title(home_team+' team VS '+away_team+' team\nBall possession in the game',fontsize=15,  fontweight= 'bold')
    pie=plt.pie(ball_possession, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, explode=explode, startangle=90, textprops={'fontsize': 11,'fontweight':'bold'})
    #plt.legend(pie[0],legends,loc='lower right')
    plt.legend(pie[0],legends)
    plt.axis('equal')
    plt.ioff()
    plt.show()

def draw_contribution_graph(is_home,team_name,member_en_name_list,member_contribution_rate_list) :
    if(is_home is True) :
        color='lightcoral'
    else :
        color='lightskyblue'
        
    contribution_fig=plt.figure()
    plt.title(team_name+' team member\'s contribution\n', fontsize=15,  fontweight= 'bold')
    
    plt.bar(member_en_name_list, member_contribution_rate_list, color=color, width=0.5, align='center')
    #plt.axis('equal')
    
    plt.xlim(-1,len(member_en_name_list))
    plt.ylim(0,100)
    plt.xlabel('Member Name')
    plt.ylabel('Member Contribution')
    
    for i,v in enumerate(member_en_name_list):
        str_val= str(member_contribution_rate_list[i])+' %'
        plt.text(v,member_contribution_rate_list[i],str_val,fontsize=10,horizontalalignment='center',verticalalignment='bottom')
    plt.ioff()
    plt.show()


def destroy_graph() :
    global fig
    is_window_open = False
    plt.clf()
    plt.close(fig)
    plt.close()
    
'''
def draw_graph(time, speed, move_ratio, playername) :
    
    x_values = [0, 1, 2, 3, 4]
    y_values = [0, 1, 4, 9, 16]
        
    ax=plt.subplot(2,1,1)
    plt.plot(x_values, y_values, marker='o',linewidth=3,color='dodgerblue')
    #ax.imshow(cv2.cvtColor(radar, cv2.COLOR_BGR2RGB))
    #ax.set_title('Jumok community')
    #ax.axis("off")
    
    plt.subplot(2,2,3)
    plt.plot(time, speed,linewidth=1,color='dodgerblue')
    plt.ion()

    plt.xlabel('Play Time(sec)',fontsize=10)
    plt.ylabel('Speed(km/h)',fontsize=10)
    plt.title(playername+'\'s speed in the game',fontsize=10)
    plt.grid(True)
    
    #plt.legend([name + '\'s speed'])
    #speed_ratio = [50.2,40.3,9.5]
    labels = 'walk', 'jog', 'splint'
    colors= "#f5f5dc", "#a5ea89", "#6ccad0"
    
    
    ax=plt.subplot(2,2,4)
    ax.clear()
    plt.title(playername+'\'s speed ratio in the game',fontsize=10)
    pie=plt.pie(move_ratio, labels=labels, colors=colors, autopct='%1.1f%%', shadow=False, startangle=90)
    
    ## 원에 퍼센트 보이게 확장 pie=plt.pie(move_ratio, labels=labels, colors=colors, autopct='%1.1f%%', shadow=False, startangle=90, pctdistance = 0.85, explode = (0.05,0.05,0.05))
    
    #pie=plt.pie(move_ratio, colors=colors, shadow=False, startangle=90)
    
    plt.legend(pie[0],labels,loc='lower right')
    #fig.canvas.draw()
    #fig.canvas.flush_events()
    # 라벨 텍스트 겹침현상 해결하는방법
    #draw circle
    centre_circle = plt.Circle((0,0),0.70,fc='white')
    fig = plt.gcf()
    fig.gca().add_artist(centre_circle)
    

    
    plt.tight_layout()
    plt.show()
'''
