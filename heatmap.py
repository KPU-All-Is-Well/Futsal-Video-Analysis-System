# 텍스트파일의 x,y 좌표를 바탕으로 히트맵을 출력해주는 heatmap.py

import numpy as np                         
from scipy.stats.kde import gaussian_kde
import matplotlib.pyplot as plt

def printHeatMap(image_x, image_y) :
    x, y = np.genfromtxt('player_coord.txt', delimiter=',', unpack=True)
    # y = y[np.logical_not(np.isnan(y))]
    # x = x[np.logical_not(np.isnan(x))]

    k = gaussian_kde(np.vstack([x, y]))
    xi, yi = np.mgrid[0:image_y:y.size**0.5*1j,0:image_x:x.size**0.5*1j] 
    zi = k(np.vstack([yi.flatten(),xi.flatten()]))

    Z, xedges, yedges = np.histogram2d(x, y)
    plt.pcolormesh(xedges, yedges, Z.T)

    
    fig = plt.figure(figsize=(7,8))
    # ax1 = fig.add_subplot(211)
    ax2 = fig.add_subplot(111)

    # alpha=0.5를 통해 색을 반투명하게 설정
    # ax1.pcolormesh(xi, yi, zi.reshape(xi.shape), alpha=0.5)
    ax2.contourf(xi, yi, zi.reshape(xi.shape), alpha=0.5, cmap='RdYlBu_r')

    # ax1.set_xlim(0, image_y)
    # ax1.set_ylim(image_x, 0)
    ax2.set_xlim(0, image_y)
    ax2.set_ylim(image_x, 0)
    # ax1.axis('off')
    ax2.axis('off')

    # 미리 지정한 pitch에 덮어씌우기
    im = plt.imread('heatmap2.png')
    # ax1.imshow(im, extent=[0, image_y, image_x,0 ], aspect='auto')
    ax2.imshow(im, extent=[0, image_y, image_x,0 ])

    fig.savefig('result_heatmap.png', bbox_inches='tight')

if __name__ == "__main__":
    printHeatMap(337,600)   # 테스트용 하드코딩
    plt.show()

# 참고 컬러바 출력 코드
# ax=plt.gca() #get the current axes
# PCM=ax.get_children()[2] #get the mappable, the 1st and the 2nd are the x and y axes
# plt.colorbar(PCM, ax=ax) 