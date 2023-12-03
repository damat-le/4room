import os
import pandas as pd

class BehaviourData:
    def __init__(self, c, rat_name) -> None:
        self.rat_name = rat_name
        self.bdata_dir = os.path.join(c["root_data_dir"], c["bdata_subdir"], rat_name)
        _,dirnames,_ = next(os.walk(self.bdata_dir))
        for session_dir in dirnames:
            if session_dir.startswith("S"):
                self.__setattr__(
                    session_dir, 
                    BehaviourSessionData(os.path.join(self.bdata_dir, session_dir))
                )

class BehaviourSessionData:
    def __init__(self, session_dir):
        _,_,filenames = next(os.walk(session_dir))
        for filename in filenames:
            if filename.endswith(".csv"):
                
                try:
                    attr_value = pd.read_csv(os.path.join(session_dir, filename), header=None)
                except:
                    print(f"attribute {filename} set to None")
                    attr_value  = None      
                
                self.__setattr__(
                    filename[:-4], 
                    attr_value
                )