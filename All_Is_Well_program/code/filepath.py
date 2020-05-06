import tkinter as tk
from tkinter import filedialog

class OpenPath:
    def __init__(self):
        self.video_path = filedialog.askopenfilename(initialdir ="./")

#path_root=OpenPath()
#print(path_root.video_path)