import os
from .behaviour_data import BehaviourSessionData
from .neural_data import NeuralSessionData

class SessionData:
    def __init__(self, session_dir_bdata, session_dir_ndata) -> None:

        self.behaviour = BehaviourSessionData(session_dir_bdata)
        self.neural = NeuralSessionData(session_dir_ndata)


class RatData:
    def __init__(self, c, rat_name) -> None:
        self.rat_name = rat_name
        self.bdata_dir = os.path.join(c["root_data_dir"], c["bdata_subdir"], rat_name)
        self.ndata_dir = os.path.join(c["root_data_dir"], c["ndata_subdir"], rat_name)
        
        session_names = ['S8a']

        for session_name in session_names: 

            session_dir_bdata = os.path.join(self.bdata_dir, session_name)
            session_dir_ndata = os.path.join(self.ndata_dir, session_name)

            self.__setattr__(
                session_name, 
                SessionData(session_dir_bdata, session_dir_ndata)
            )
