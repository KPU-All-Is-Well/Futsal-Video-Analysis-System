import tkinter as tk
from tkinter import filedialog

class OpenPath:
    def __init__(self):
        self.path = tk.Tk()
        self.path.withdraw()
        self.video_path = filedialog.askopenfilename(initialdir ="./")
        self.path.destroy()

#path_root=OpenPath()
#print(path_root.video_path)