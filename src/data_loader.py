import os
import multiprocessing as mp
import pandas as pd
import numpy as np

class RatDataLoader:
    def __init__(self, c, rat_name) -> None:
        self.rat_name = rat_name
        self.c = c
        
        self.rat_name = rat_name
        bdata_dir = self.__get_ratdata_dir('b')
        ndata_dir = self.__get_ratdata_dir('n')
        self.bdata_dir = bdata_dir
        self.ndata_dir = os.path.join(c["root_data_dir"], c["ndata_subdir"], rat_name)

        sessions_toload = set(self.session_names).intersection(c["selected_sessions"])
        
    def __get_ratdata_dir(self, data_type):
        if data_type=='n':
            data_subdir = self.c["ndata_subdir"]
        elif data_type=='b':
            data_subdir = self.c["bdata_subdir"]
        return os.path.join(
            self.c["root_data_dir"], 
            data_subdir, 
            self.rat_name
            )
    
    


class BehaviourDataLoader:
    """
    For a given session, it loads the behaviour data.
    """
    def __init__(self, session_dir) -> None:
        pass


class BaseDataLoader:

    

        
        results = self.load_dirs_parallel(self.bdata_dir, n_jobs=c["n_jobs"])

        for session_name, session_dict in results:
            self.__setattr__(
                session_name, 
                session_dict
            )

    def load_dirs_parallel(self, in_dir, n_jobs=1) -> dict:
        _,sub_dirs,_ = next(os.walk(in_dir))

        # parallelize sub_dirs loading
        sub_dirs = [os.path.join(in_dir, sub_dir) for sub_dir in sub_dirs if sub_dir.startswith("S")]

        with mp.Pool(n_jobs) as pool:
            results = pool.map(
                self.load_files, 
                sub_dirs
            )
        
        return results

    def load_files(self, in_dir) -> dict:
        out_dict = {}
        _,_,filenames = next(os.walk(in_dir))
        for filename in filenames:
            if filename.endswith(".csv"):
                
                try:
                    attr_value = pd.read_csv(os.path.join(in_dir, filename), header=None).values
                except:
                    print(f"attribute {filename} set to None")
                    attr_value  = None   

                out_dict[filename[:-4]] = attr_value

        #get name of parent folder
        in_dir_name = os.path.basename(os.path.normpath(in_dir))
                

        return in_dir_name, out_dict