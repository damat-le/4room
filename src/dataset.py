import os
import pickle
import pandas as pd
from numpy import ndarray

class BaseContainer:
    def __init__(self, **kwargs) -> None:
        self.__dict__.update(kwargs)

    @property
    def keys(self):
        return sorted(self.__dict__.keys())
    
    @property
    def items(self):
        return sorted(
            self.__dict__.items(),
            key=lambda x: x[0]
            )
    
    def get(self, key):
        return self.__dict__[key]

class Dataset(BaseContainer):
    def __init__(
        self, 
        data_dir: str, 
        data_fn='data.pickle', 
        registry_fn='registry.csv'
        ) -> None:

        path2registry = os.path.join(data_dir, registry_fn)
        path2data = os.path.join(data_dir, data_fn)
        registry = pd.read_csv(path2registry)
        data = pickle.load(open(path2data, 'rb'))

        rats = registry.rat.unique()

        tmp = registry.copy()
        for rat in rats:
            rat_obj = BaseContainer()
            rtmp = tmp[tmp.rat == rat]
            sessions = rtmp.session.unique()
            for session in sessions:
                session_obj = BaseContainer()
                stmp = rtmp[rtmp.session == session]
                data_types = stmp.data_type.unique()
                
                for data_type in data_types:

                    if data_type == 'behaviour':
                        dtmp = stmp[stmp.data_type == data_type]
                        assert dtmp.shape[0] == 1
                        content = data[dtmp.hash.values[0]]
                        content = self.parse_data(content)
                        session_obj.__setattr__(
                            data_type, 
                            BaseContainer(**content)
                            )
                        del data[dtmp.hash.values[0]]
                        
                    if data_type == 'neural':
                        cells_obj = BaseContainer()
                        dtmp = stmp[stmp.data_type == data_type]
                        cells = dtmp.cell.unique()
                        for cell in cells:
                            ctmp = dtmp[dtmp.cell == cell]
                            assert ctmp.shape[0] == 1
                            content = data[ctmp.hash.values[0]]
                            content = self.parse_data(content)
                            cells_obj.__setattr__(
                                cell.replace('.', '_'),
                                BaseContainer(**content)
                                )
                            del data[ctmp.hash.values[0]]
                        session_obj.__setattr__(
                            data_type, 
                            cells_obj
                            )

                
                rat_obj.__setattr__(
                    session, 
                    session_obj
                    )
            self.__setattr__(
                rat, 
                rat_obj
                )
    
    @staticmethod
    def parse_data(data):
        for k, v in data.items():
            if isinstance(v, ndarray):
                if v.shape == (1,1):
                    v = v[0,0]
                    data[k] = v
        return data
