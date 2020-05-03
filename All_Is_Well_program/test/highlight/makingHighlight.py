from moviepy.editor import *
from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip


#video = VideoFileClip("TEST.mp4").cutout(10, 15)
#video.write_videofile("new.mp4")      
#video.close()
start = 0
end = 5 
ffmpeg_extract_subclip("TEST.mov", start, end, targetname="highlight.mov")


