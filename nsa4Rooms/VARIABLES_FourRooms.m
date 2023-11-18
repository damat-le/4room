i_Rat          =    1;
i_Uci          =    5;
i_spike_times  =   10;
i_spike_index      =    8;
i_part             =    4;
i_rate_map         =   27;
Rat35_name         ='r35';
i_session          =    5;
parts              ='abcde';

EVENT_CHAR=cell(0,0);
AB_open_attempt    ='1';EVENT_CHAR{end+1}=AB_open_attempt;
BA_open_attempt    ='2';EVENT_CHAR{end+1}=BA_open_attempt;
BC_open_attempt    ='3';EVENT_CHAR{end+1}=BC_open_attempt;
CB_open_attempt    ='4';EVENT_CHAR{end+1}=CB_open_attempt;
CD_open_attempt    ='5';EVENT_CHAR{end+1}=CD_open_attempt;
DC_open_attempt    ='6';EVENT_CHAR{end+1}=DC_open_attempt;
DA_open_attempt    ='7';EVENT_CHAR{end+1}=DA_open_attempt;
AD_open_attempt    ='8';EVENT_CHAR{end+1}=AD_open_attempt;

bell_sound_in_box_A='a';EVENT_CHAR{end+1}=bell_sound_in_box_A; 
bell_sound_in_box_B='b';EVENT_CHAR{end+1}=bell_sound_in_box_B;
bell_sound_in_box_C='c';EVENT_CHAR{end+1}=bell_sound_in_box_C; 
bell_sound_in_box_D='d';EVENT_CHAR{end+1}=bell_sound_in_box_D;
start_of_session   ='s';EVENT_CHAR{end+1}=start_of_session;
end_of_session     ='e';EVENT_CHAR{end+1}=end_of_session;

grooming           ='g';EVENT_CHAR{end+1}=grooming;
rearing            ='u';EVENT_CHAR{end+1}=rearing;
VTE                ='v';EVENT_CHAR{end+1}=VTE;

%%
EVENTS=cell(0,0);
AB_open_attempt_string    ='AB open attempt';    EVENTS{end+1}=AB_open_attempt_string;
BA_open_attempt_string    ='BA open attempt';    EVENTS{end+1}=BA_open_attempt_string;
BC_open_attempt_string    ='BC open attempt';    EVENTS{end+1}=BC_open_attempt_string;
CB_open_attempt_string    ='CB open attempt';    EVENTS{end+1}=CB_open_attempt_string;
CD_open_attempt_string    ='CD open attempt';    EVENTS{end+1}=CD_open_attempt_string;
DC_open_attempt_string    ='DC open attempt';    EVENTS{end+1}=DC_open_attempt_string;
DA_open_attempt_string    ='DA open attempt';    EVENTS{end+1}=DA_open_attempt_string;
AD_open_attempt_string    ='AD open attempt';    EVENTS{end+1}=AD_open_attempt_string;

bell_sound_in_box_A_string='bell sound in box A';EVENTS{end+1}=bell_sound_in_box_A_string;
bell_sound_in_box_B_string='bell sound in box B';EVENTS{end+1}=bell_sound_in_box_B_string;
bell_sound_in_box_C_string='bell sound in box C';EVENTS{end+1}=bell_sound_in_box_C_string;
bell_sound_in_box_D_string='bell sound in box D';EVENTS{end+1}=bell_sound_in_box_D_string;
start_of_session_string   ='start of session';   EVENTS{end+1}=start_of_session_string;
end_of_session_string     ='end of session';     EVENTS{end+1}=end_of_session_string;
grooming_string           ='grooming';           EVENTS{end+1}=grooming_string;
rearing_string            ='rearing';            EVENTS{end+1}=rearing_string;
VTE_string                ='VTE';                EVENTS{end+1}=VTE_string;


direct             =  1;
foraging           =  2;
BEHAVIOURS         ={'direct','foraging'};
COMPS = {'A','B','C','D'};
comps=COMPS;

% DA_OPEN_ATTEMPT_DELAY_S8a =[-6,-6,-2,-1.9,-3.5,-3.2,-1,-1,-1.5,-2.3,-1.5];

EVENT_DELAY.r35.S8a.(['EV' DA_open_attempt])=[-6  ,-6  ,-2  ,-1.9,-3.5,-3.2,-1  ,-1  ,-1.5,-2.3,-1.5];
EVENT_DELAY.r35.S8b.(['EV' DA_open_attempt])=[-7,  -1  ,-0.8,-2.6,-1  ,-2.5,-3.5,-1.9, NaN,-1.4,-1.2,  -6,-1  ,-7.8,-1.7,-2.6,-0.9,-0.6];
EVENT_DELAY.r35.S8c.(['EV' DA_open_attempt])=[-1.8,-0.8,-2  ,-0.9,-0.9,-5  ,-3.8,-1.8];
EVENT_DELAY.r35.S8d.(['EV' DA_open_attempt])=[-6  ,-3  ,-1  ,-1.6,-1  ,-2  ,-1.8,-1  ];
EVENT_DELAY.r35.S8e.(['EV' DA_open_attempt])=[-4.1,-2.2,-1.2,-0.6,-1.8,-3.9,-2.9,-3.2,-1.1,-1.6,-1.6,-1.5,-2.3];


BELL_T_AFTER=0.5;
BELL_T_DELTA=1.5;

ALLOWED_TRANSITIONS  = [ 1 2;  2 3;  3 4;  1 4];   % possible transitions - bidirectional
DOORS                = {'AB', 'BC', 'CD', 'AD'};
DIRECTIONS           = [1:1:2;2:-1:1];
DOOR_APPROACH_1      = 1;
DOOR_APPROACH_2      = 2;
BELL_APPROACH        = 3;
%     visit_info                                = all visits (one per row) to all compartments
%                                                   visit number
%                                                   start of visit
%                                                   end of visit
%                                                   length of the visit in s
%                                                   length of the visit in cm
%                                                   area of the box covered in this visit (%)
%                                                   0 = discard, 1 = direct, 2 = foraging
%                                                   mean speed during visit