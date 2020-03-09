import tkinter as tk
from tkinter import filedialog

def openfile():
    path = tk.Tk()
    path.withdraw()

    video_path = filedialog.askopenfilename(initialdir ="./")
    return video_path