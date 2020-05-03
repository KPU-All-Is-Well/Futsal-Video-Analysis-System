# 텍스트파일의 x,y 좌표를 바탕으로 히트맵을 출력해주는 heatmap.py

import numpy as np                         
from scipy.stats.kde import gaussian_kde
import matplotlib.pyplot as plt

def printHeatMap(image_x, image_y) :
    x, y = np.genfromtxt('player_coord.txt', delimiter=',', unpack=True)

    k = gaussian_kde(np.vstack([x, y]))
    xi, yi = np.mgrid[0:image_y:y.size**0.5*1j,0:image_x:x.size**0.5*1j] 
    zi = k(np.vstack([yi.flatten(),xi.flatten()]))

    Z, xedges, yedges = np.histogram2d(x, y)
    plt.pcolormesh(xedges, yedges, Z.T)

    # 공백 제거
    plt.xticks([]), plt.yticks([])
    plt.tight_layout()
    plt.subplots_adjust(left = 0, bottom = 0, right = 1, top = 1, hspace = 0, wspace = 0)
    fig = plt.figure(figsize=(image_y/101.0,image_x/100.0))

    ax = fig.add_subplot(111)

    # alpha=0.5를 통해 색을 반투명하게 설정
    ax.contourf(xi, yi, zi.reshape(xi.shape), alpha=0.5, cmap='RdYlBu_r')

    ax.set_xlim(0, image_y)
    ax.set_ylim(image_x, 0)
    ax.axis('off')
    ax.autoscale(False)
    ext = ax.get_window_extent().transformed(plt.gcf().dpi_scale_trans.inverted())

    # 미리 지정한 pitch에 덮어씌우기
    im = plt.imread('heatmap.png')
    ax.imshow(im, extent=[0, image_y, image_x,0 ])

    fig.savefig('result_heatmap.png', bbox_inches=ext)

if __name__ == "__main__":
    printHeatMap(337,600)   # 테스트용 하드코딩
    plt.show()


# 참고 컬러바 출력 코드
# ax=plt.gca() #get the current axes
# PCM=ax.get_children()[2] #get the mappable, the 1st and the 2nd are the x and y axes
# plt.colorbar(PCM, ax=ax) 