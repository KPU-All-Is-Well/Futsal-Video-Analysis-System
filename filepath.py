import tkinter as tk
from tkinter import filedialog

def openfile():
    path = tk.Tk()
    path.withdraw()

    video_path = filedialog.askopenfilename()
    return video_path