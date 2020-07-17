from matplotlib import pyplot as plt

#fig=plt.figure()

is_window_open = False
fig=None

def drow_graph(time, speed, move_ratio, playername) :
    global is_window_open
    global fig

    if (is_window_open == False) :
        is_window_open = True
        fig=plt.figure()
        
    plt.subplot(1,2,1)
    plt.ion()
    plt.plot(time, speed,linewidth=1,color='dodgerblue')
    

    plt.xlabel('Play Time(sec)',fontsize=10)
    plt.ylabel('Speed(km/h)',fontsize=10)
    plt.title(playername+'\'s speed in the game',fontsize=10)
    plt.grid(True)
    
    #plt.legend([name + '\'s speed'])
    #speed_ratio = [50.2,40.3,9.5]
    labels = 'walk', 'jog', 'splint'
    colors= "#f5f5dc", "#a5ea89", "#6ccad0"
    
    
    ax=plt.subplot(1,2,2)
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
    #centre_circle = plt.Circle((0,0),0.70,fc='white')
    #fig = plt.gcf()
    #fig.gca().add_artist(centre_circle)
    

    
    plt.tight_layout()
    
    plt.show()

def destroy_graph() :
    global fig
    is_window_open = False
    plt.close(fig)
    
'''
def drow_graph(time, speed, move_ratio, playername) :
    
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
