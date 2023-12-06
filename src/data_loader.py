import os
import pandas as pd
import multiprocessing as mp


class DataLoader:

    def __init__(self, c) -> None:
        self.root_dir = c["root_data_dir"]
        self.rat_names = c["rats_toload"]
        self.session_names = c["sessions_toload"]
        self.data_types = c["datatype_toload"]
        self.n_jobs = c["n_jobs"]
        self.targets = self.__get_targets()

    def load(self):
        self.data = self.__load_targets()
    
    def __build_all_targets(self) -> dict:
        targets = []
        for path, dirs, files in os.walk(self.root_dir):
            if files:
                targets.append(path)
        
        df1 = pd.DataFrame(
            targets, 
            columns=['path']
        )
        tmp = df1.path.str.replace(self.root_dir+'/', '', regex=False).str.split('/').tolist()
        for t in tmp:
            if len(t) == 3:
                t.append(None)

        df2 = pd.DataFrame(
            tmp,
            columns=['data_type', 'rat', 'session', 'cell']
        )
        #df2['cell'] = df2.cell.str.replace('.', '_', regex=False)

        df = pd.concat([df2, df1], axis=1)
        df["hash"] = df.path.apply(hash)
        
        return df
    
    def __filter_targets(self, df) -> dict:
        if self.rat_names is None:
            self.rat_names = df.rat.unique()
        if self.session_names is None:
            self.session_names = df.session.unique()
        if self.data_types is None:
            self.data_types = df.data_type.unique()
        return df[
            df.rat.isin(self.rat_names) &
            df.session.isin(self.session_names) &
            df.data_type.isin(self.data_types)
            ]
    
    def __get_targets(self) -> dict:
        df = self.__build_all_targets()
        df = self.__filter_targets(df)
        return df
    
    def __load_targets(self) -> dict:
        with mp.Pool(self.n_jobs) as pool:
            data = pool.map(
                self.load_files, 
                [(r.hash, r.path) for r in self.targets.itertuples()]
            )
        return dict(data)
    
    @staticmethod
    def load_files(in_tuple) -> tuple[int, dict]:
        """
        Load all files in a directory. 

        The output is a container object with attributes corresponding to the filenames. The container has an ID attribute corresponding to the directory name.
        """
        _hash, in_dir = in_tuple

        out_dict = {}
        _,_,filenames = next(os.walk(in_dir))
        for filename in filenames:
            if filename.endswith(".csv"):
                
                try:
                    attr_value = pd.read_csv(
                        os.path.join(in_dir, filename), 
                        header=None
                    ).values
                except:
                    print(f"attribute {filename} set to None")
                    attr_value = None   

                out_dict[filename[:-4]] = attr_value
        return _hash, out_dict

if __name__=='__main__':
    import json
    import pickle
    from argparse import ArgumentParser

    parser = ArgumentParser()
    parser.add_argument('-c', type=str, required=True, help='path to config file')

    args = parser.parse_args()
    with open(args.c, "r") as f:
        c = json.load(f)

    dl = DataLoader(c)
    dl.load()

    dl.targets.to_csv('data/pickle/info.csv', index=False)
    with open('data/pickle/data.pickle', 'wb') as f:
        pickle.dump(dl.data, f)
