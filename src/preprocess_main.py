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

        sessions_toload = set(self.session_names).intersection(c["selected_sessions"])

        for session_name in sessions_toload: 

            session_dir_bdata = os.path.join(self.bdata_dir, session_name)
            session_dir_ndata = os.path.join(self.ndata_dir, session_name)

            print(f'rat {rat_name}. Loading session {session_name}...')
            self.__setattr__(
                session_name, 
                SessionData(session_dir_bdata, session_dir_ndata)
            )
            print('...done')

    @property
    def session_names(self):
        b_sess_names = set([s for s in os.listdir(self.bdata_dir) if s.startswith('S')])
        n_sess_names = set([s for s in os.listdir(self.ndata_dir) if s.startswith('S')])

        if len(b_sess_names.symmetric_difference(n_sess_names)) != 0:
            raise ValueError("Session directories for behaviour and neural data do not match")

        return sorted(list(b_sess_names))