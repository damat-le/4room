import os
import pandas as pd


class NeuralData:
    def __init__(self, c, rat_name) -> None:
        self.rat_name = rat_name
        self.ndata_dir = os.path.join(c["root_data_dir"], c["ndata_subdir"], rat_name)
        _,dirnames,_ = next(os.walk(self.ndata_dir))
        for session_dir in dirnames:
            if session_dir.startswith("S"):
                self.__setattr__(
                    session_dir, 
                    NeuralSessionData(os.path.join(self.ndata_dir, session_dir))
                )      

class NeuralSessionData:
    def __init__(self, session_dir) -> None:
        self.session_dir = session_dir
        _,dirnames,_ = next(os.walk(self.session_dir))
        print(dirnames)
        for cell_name in dirnames:
            if cell_name.startswith("r"):
                self.__setattr__(
                    cell_name.replace(".", "_"),
                    CellData(os.path.join(self.session_dir, cell_name))
                )

class CellData:
    def __init__(self, cell_dir):
        _,_,filenames = next(os.walk(cell_dir))
        for filename in filenames:
            if filename.endswith(".csv"):
                
                try:
                    attr_value = pd.read_csv(os.path.join(cell_dir, filename), header=None)
                except:
                    print(f"attribute {filename} set to None")
                    attr_value  = None      
                
                self.__setattr__(
                    filename[:-4], 
                    attr_value
                )