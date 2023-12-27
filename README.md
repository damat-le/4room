# Overall introduction

Reference file for .mat data files provided for dataset comprising Duvelle et al. (2020)
Roddy Grieves (r.grieves@ucl.ac.uk)
updated 30/03/202

Each day rats are placed in the maze and a recording is made which can be around 3 hours long in total. These recordings include different sessions (which are called 'parts' in matlab code etc). 

The first 2 sessions are always with all 2 doors open, the 3rd and 4th sessions have some sort of door
change (either one door closed both ways or all doors closed one-way). The last session is a repeat of the first two, with all doors open.

The data are split between two large Matlab tables, the behaviour data (trial time, door push success
speed, position, event flags etc) are stored in bdata_big.mat. Each recording spans 5 rows of this table, each row corresponding to a part/session as described above. Initial columns contain basic information about the session such as which door was closed, the rat, date etc. Later columns get progressively more and more specific. 

Spike data (spike times, waveforms, cluster quality, firing rate maps, correlations etc) are stored in sdata_big.mat. Each cluster spans 5 rows of this table, each row corresponding to a part/session as described above. Initial columns contain basic information about the session such as which door was closed, the rat, date etc. Later columns get progressively more and more specific, the last columns contain the different firing rate maps and correlation matrices that form the basis of the main results. 

A description of some nomenclature (imposed by experimenters not me). The top left box when the maze is viewed from above is box 'A' the other boxes are lettered successively in clockwise order. Similarly, the doors are named using two letters where the letters represent the doors on either side e.g. door AB is between box A and box B. However, the doors also have directions, so door AB is actually the door when pushed from box A. Door BA would be the same door when pushed from box B.

# BDATA contents

## Basic/session/part info

- `rat`                                       = rat name as in spreadsheet
- `date`                                      = date as in sdata/klustest
- `partn`                                     = part number/order, 1-5 corresponding to a-e
- `part`                                      = the part specified in klustest
- `part2`                                     = the overall part name
- `duration`                                  = the total length of the part in seconds
- `directory`                                 = the absolute directory of the data files
- `positions`                                 = position data for this part, [x y time], time is in seconds from start of whole recording
- `speed`                                     = running speed for this part in cm/s
- `HD`                                        = head direction for this part in degrees
- `dwellmap`                                  = the dwellmap for this part, in seconds
- `HDdwellmap`                                = the head direction dwellmap, bin angles are: rad2deg(linspace(0,2*pi,64)')
- `phase`                                     = the phase of the experiment, as in spreadsheet
- `sequence`                                  = sequence letter, as in spreadsheet
- `closed_doors`                              = closed doors, string as in spreadsheet

## Door state and recorded event flags

doormat has 3 rows, rows represent directions: clockwise (AB), cclockwise (BA), both (AB-BA)
columns represent doorways: 1 (AB), 2 (BC), 3 (CD), 4 (DA).

doormat is true when the door is closed in a direction. If the door is closed in both directions all rows will be true
doormat is false when the door is open in a direction. If the door is open completely all rows will be false.

- `event_flag_values`                         = cell array of even flag values
                                                G = grooming, u = rearing, v = VTE
                                                1 = AB open attempt, 2 = BA open attempt, 3 = BC open attempt, 4 = CB open attempt, 5 = CD open attempt, 6 = DC open attempt, 7 = DA open attempt, 8 = AD open attempt
                                                A = bell sound in box b, B = bell sound in box b, C = bell sound in box c, D = bell sound in box d
                                                s = start of session, e = end of session
- `Grievesevent_flag_times`                   = the time in seconds since the start of the whole recording corresponding to each event flag
- `door_states`                               = the state of each door from each side: AB, BC, CD, DA, BA, CB, DC, AD, 1 for closed, 0 for open
- `num_closed_directions`                     = the total number of directions (i.e. one-way options) that were closed. 
                                                i.e. if a door is closed in both directions it would add 2 to this column
- `num_open_directions`                       = the total number of directions (i.e. one-way options) that were open. 
                                                i.e. if a door is open in both directions it would add 2 to this column, if it was open in one direction it would ass 1 to this column
- `num_closed_doors`                          = the total number of doors that are completely closed

## Door push behaviour
- `door_pushes`                               = the number of times the rat pushed each door from each side: AB, BC, CD, DA, BA, CB, DC, AD
- `closed_door_push`                          = number of times the rat tried to open a closed door in this part
                                                This only includes when the rat tried to open a completely closed door
                                                Or when he tried to open a one-way door in the closed direction
- `open_door_push`                            = number of times the rat tried to open an open door in this part
                                                This only includes when the rat tried to open a completely open door
                                                Or when he tried to open a one-way door in the open direction
- `closed_push_prop`                          = the number of times a closed door direction was pushed / the total number of closed door directions / second
                                                i.e. a door has 2 directions, which can be either closed or open, so these are counted seperately
- `open_push_prop`                            = the number of times an open door direction was pushed / the total number of open door directions / second
                                                i.e. a door has 2 directions, which can be either closed or open, so these are counted seperately
- `push_diff`                                 = open_door_prop - closed_door_prop
- `CTRL_closed_door_push`                     = number of times the rat tried to open a closed door in this part (includes doors closed later in the day)
                                                This only includes when the rat tried to open a completely closed door
                                                Or when he tried to open a one-way door in the closed direction
- `CTRL_open_door_push`                       = number of times the rat tried to open an open door in this part (includes only doors open throughout the day)
                                                This only includes when the rat tried to open a completely open door
                                                Or when he tried to open a one-way door in the open direction
- `CTRL_closed_push_prop`                     = the number of times a closed door direction was pushed / the total number of closed door directions / second  (includes doors closed later in the day)
                                                i.e. a door has 2 directions, which can be either closed or open, so these are counted seperately
- `CTRL_open_push_prop`                       = the number of times an open door direction was pushed / the total number of open door directions / second (includes only doors open throughout the day)
                                                i.e. a door has 2 directions, which can be either closed or open, so these are counted seperately
- `CTRL_push_diff`                            = CTRL_open_push_prop - CTRL_closed_push_prop
- `control_over_time`                         = pushes on the closed/changing doors split into 8 equal length segments
- `correct_over_time`                         = pushes on the open/unchanging doors split into 8 equal length segments

## Overall very basic info on event flags (requested by exps.)
- `all_grooms`                                = total number of grooming events in this part
- `comp_grooms`                               = total number of grooming events per compartment
- `all_rears`                                 = total number of rearing events in this part
- `comp_rears`                                = total number of rearing events per compartment
- `all_vtes`                                  = total number of vte events in this part
- `comp_vtes`                                 = total number of VTEs per compartment
- `all_keys`                                  = count of all event flags in each session: {'g','u','v','1','2','3','4','5','6','7','8','a','b','c','d'};
also see event_flag_values and event_flag_times above

## Basic information about visits to boxes
- `comp_index`                                = for all position data, the compartment associated with that pos, columns 1:4 represent boxes A-D
- `comp_time`                                 = total time spent in each compartment: A, B, C, D
- `behaviour_index`                           = N x 1 vector where N = number of position data samples. 
                                                1 = the animals behaviour was categorised as goal-directed
                                                2 = the animals behaviour was categorised as foraging
- `bell_speeds_min1_to_plus1`                 = mean speed in the 1s before a bell and the 1s after

## Bell behaviour, door pushing in response to bells, optimality of foraging and door choice
- `correct_bell`                              = for each session [incorrect correct total] 1st foraging choices
- `correct_first_door`                        = for each session [incorrect correct total] 1st door choices
- `graph`                                     = matlab graph object that can be used for optimal path search
- `correct_bell_index`                        = one row per trial:
                                                column 1: 1st bell time (trial start)
                                                column 2: 2nd bell time (trial end)
                                                column 3: 1st compartment (box at start/when bell happens)
                                                column 4: 2nd compartment (box at end/rewarded box)   
                                                column 5: error messages as a formatted string
                                                column 6: 1st foraging compartment
                                                column 7: 1st foraging correct or not
                                                column 8: Time between bell and foraging in the correct compartment                
                                                column 9: Time between bell and moving to a new (any) compartment
                                                column 10: Average speed 1s before the bell
                                                column 11: Average speed 1s after the bell
                                                column 12: 1st door push choice after the bell
                                                column 13: Time of the 1st door push choice after the bell
                                                column 14: Time between the bell and 1st door push
                                                column 15: Shortest path the rat could have taken to correct box
                                                column 16: Optimal door the rat should have pushed on
                                                column 17: 1st push optimal or not 
- `prop_corr_dist`                            = the proportion of door pushes that are optimal with increasing compartment distance (1-3)
- `num_per_dist`                              = the number of trials at each compartment distance (1-3)
- `prop_corr_dist_push`                       = the proportion of foraging that is correct with increasing compartment distance (1-3)
- `num_per_dist_push`                         = the number of trials at each compartment distance (1-3)
- `bell_response_times`                       = time between hearing the bell and moving to a new compartment
                                                second column represents the same values calculated using random time points
# SDATA contents

## Basic/session/part info
- `rat`                                       = rat name as provided in klustest
- `date`                                      = recording date
- `partn`                                     = recordings are divided into 'parts', each with a different name, this is the numerical order of this row's part
- `part`                                      = the part name, given in klustest
- `uci`                                       = string, unique cell identifier
- `tet`                                       = tetrode that the cell was recorded on
- `clu`                                       = cluster of the cell on this tetrode
- `spike_index`                               = given all the position data, this is an index giving the position data samples corresponding to each spike
- `part_spike_index`                          = given the position data for just this part, this is an index giving the position data samples corresponding to each spike
- `spike_times`                               = the spike times, within all of the recordings (not within the part!)
- `isod`                                      = isolation distance of the cluster
- `lratio`                                    = lratio of the cluster
- `spikes`                                    = the number of spikes recorded
- `duration`                                  = the duration of the recording session in seconds
- `frate`                                     = the firing rate of the cell, given 'spikes' and 'duration'

## Waveform information
- `waveform_mean`                             = for each recording channel, the mean aplitude of all waveforms
- `waveform_stdv`                             = for each recording channel, the amplitude SD of all waveforms
- `waveform_rms`                              = for each recording channel, the root mean squared amplitude
- `waveform_snr`                              = for each recording channel, the signal to noise ratio (signal RMS / noise RMS) where noise is all spikes in a noise cluster
- `waveform_max`                              = for each recording channel, the max amplitude in the mean waveform
- `waveform_min`                              = for each recording channel, the min amplitude in the mean waveform
- `waveform_maxt`                             = for each recording channel, the time associated with the max amplitude in the mean waveform
- `waveform_mint`                             = for each recording channel, the time associated with the min amplitude in the mean waveform 
- `waveform_width`                            = for each recording channel, the width of the waveform (time between max and min amplitude)
- `waveform_params`                           = The max amplitude on all 4 channels and the width of waveform associated with that channel
- `waveform_snrs`                             = Signal to noise ratios calculated using alternative method

## Firing rate map information
- `ratemap`                                   = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Firing rate maps and dwell maps BELOW INSTEAD) firing rate map
- `spatial_info_bsec`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Firing rate maps and dwell maps BELOW INSTEAD) spatial information in bits per second
- `spatial_info_bspike`                       = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Firing rate maps and dwell maps BELOW INSTEAD) spatial information in bits per spike
- `mutual_info`                               = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Firing rate maps and dwell maps BELOW INSTEAD) mutual information (between ratemap and dwellmap)
- `sparsity`                                  = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Firing rate maps and dwell maps BELOW INSTEAD) Sparsity of ratemap
- `spatial_coherence`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Firing rate maps and dwell maps BELOW INSTEAD) Coherence of ratemap

## Place field data
- `place_fields`                              = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) number of place fields detected
- `field_area`                                = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) vector, area of each place field
- `field_centroids`                           = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) matrix, Nx2, x,y centroid of each place field
- `field_weight_centroids`                    = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) matrix, Nx2, x,y rate weighted centroid of each place field
- `field_maj_lengths`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) vector, major axis length of each field
- `field_min_lengths`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) vector, minor axis length of each field 
- `field_orientations`                        = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) vector, orientation or major axis relative to x-axis of each field 
- `field_snr`                                 = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) vector, signal to noise of each field (max frate in field / mean frate of ratemap)

## Grid analyses
- `grid_autocorrelation`                      = NOT USED IN 4 COMPARTMENT EXPERIMENT autocorrelation of firing rate map
- `grid_score`                                = NOT USED IN 4 COMPARTMENT EXPERIMENT grid score of autocorrelation
- `grid_score2`                               = NOT USED IN 4 COMPARTMENT EXPERIMENT grid score of autocorrelation, alternative method
- `grid_wavelength`                           = NOT USED IN 4 COMPARTMENT EXPERIMENT distance between grid fields
- `grid_radius`                               = NOT USED IN 4 COMPARTMENT EXPERIMENT radius of central portion of autocorrelation
- `grid_orientation`                          = NOT USED IN 4 COMPARTMENT EXPERIMENT orientation of grid
- `grid_mask`                                 = NOT USED IN 4 COMPARTMENT EXPERIMENT the mask used to cut the autocorrelation to the analysed portion
  
## Overdispersion analyses
- `over_dispersion_z`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT z-statistic associated with overdispersion metric
- `over_dispersion`                           = NOT USED IN 4 COMPARTMENT EXPERIMENT overdispersion value
- `over_dispersion_r`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT r-statistic associated with overdispersion metric
  
## Head direction analyses
- `hd_spikemap`                               = NOT USED IN 4 COMPARTMENT EXPERIMENT head direction spikemap
- `hd_ratemap`                                = NOT USED IN 4 COMPARTMENT EXPERIMENT head direction firing rate map
- `hd_rayleigh`                               = NOT USED IN 4 COMPARTMENT EXPERIMENT rayleigh vector of HD ratemap
- `hd_max`                                    = NOT USED IN 4 COMPARTMENT EXPERIMENT angle associated with max HD firing rate
- `hd_mean`                                   = NOT USED IN 4 COMPARTMENT EXPERIMENT angle associated with mean HD firing rate
- `hd_stdev`                                  = NOT USED IN 4 COMPARTMENT EXPERIMENT standard deviation around 'hd_mean'
  
## Theta phase analyses
- `theta_phase_mean`                          = NOT USED IN 4 COMPARTMENT EXPERIMENT the mean theta angle (phase) associated with all spikes
- `theta_phase_r`                             = NOT USED IN 4 COMPARTMENT EXPERIMENT rayleigh vector of these angles
- `theta_phase_max`                           = NOT USED IN 4 COMPARTMENT EXPERIMENT angle associated with max theta phase
- `theta_phase_dist`                          = NOT USED IN 4 COMPARTMENT EXPERIMENT distribution of binned theta phase values
  
## Inter spike interval analyses
- `isi_dist`                                  = NOT USED IN 4 COMPARTMENT EXPERIMENT interspike interval distribution
- `isi_fdist`                                 = NOT USED IN 4 COMPARTMENT EXPERIMENT 
- `isi_fwhmx`                                 = NOT USED IN 4 COMPARTMENT EXPERIMENT full width at half maximum in ISI
- `isi_half_width`                            = NOT USED IN 4 COMPARTMENT EXPERIMENT the length of the half width
- `burst_index`                               = NOT USED IN 4 COMPARTMENT EXPERIMENT burst index in ISI
- `burst_length_median`                       = NOT USED IN 4 COMPARTMENT EXPERIMENT the median length of spike bursts
- `burst_length_mean`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT the mean length of spike bursts
  
## Theta modulation in spike autocorrelogram
- `intrinsic_theta_index`                     = NOT USED IN 4 COMPARTMENT EXPERIMENT theta index of sine fitted to spike autocorrelation
- `intrinsic_theta_frequency`                 = NOT USED IN 4 COMPARTMENT EXPERIMENT frequency associated with this sine
- `intrinsic_theta_fit`                       = NOT USED IN 4 COMPARTMENT EXPERIMENT the fit quality of the sine
- `t500_spike_autocorr`                       = NOT USED IN 4 COMPARTMENT EXPERIMENT the 500ms spike autocorrelation
- `t500_spike_autofit`                        = NOT USED IN 4 COMPARTMENT EXPERIMENT the sine fit on the 500ms spike autocorrelation
  
## Refractory period analyses    
- `rpv_total`                                 = NOT USED IN 4 COMPARTMENT EXPERIMENT the total number of spikes falling in the refractory period
- `rpv_proportion`                            = NOT USED IN 4 COMPARTMENT EXPERIMENT what proportion of the total this makes
- `rpv_false_positive1`                       = NOT USED IN 4 COMPARTMENT EXPERIMENT the number of false positives expected
- `rpv_false_positive2`                       = NOT USED IN 4 COMPARTMENT EXPERIMENT alternative false positive measure
- `rpv_censored`                              = NOT USED IN 4 COMPARTMENT EXPERIMENT how many RPVs must be censored by the system
- `t25_spike_autocorr`                        = NOT USED IN 4 COMPARTMENT EXPERIMENT the 25ms spike autocorrelation
  
## Speed modulation
- `speed_score`                               = NOT USED IN 4 COMPARTMENT EXPERIMENT speed score of firing rate x running speed
- `speed_slope`                               = NOT USED IN 4 COMPARTMENT EXPERIMENT the slope of the bets fit line to this relationship
- `speed_y_intercept`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT the y-intercept (firing rate) of this line
- `speed_frate_curve`                         = NOT USED IN 4 COMPARTMENT EXPERIMENT the binned values of firing rate x speed
  
## Cell typing
- `cell_type`                                 = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) the estimated cell type in text
- `cell_type_int`                             = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) the estimated cell type in integer
- `cell_type_bin`                             = NOT USED IN 4 COMPARTMENT EXPERIMENT (SEE SECTION Field and cell typing data INSTEAD) binary representation of the cell type features
  
## Data specific to the four compartment maze    
- `compartment_index`                         = for all spikes, the compartment associated with that spike, columns 1:4 represent boxes A-D
- `phase`                                     = the phase of the experiment, as in spreadsheet
- `sequence`                                  = sequence letter, as in spreadsheet
- `closed_doors`                              = closed doors, string as in spreadsheet
- `doormat`                                   = doormat has 3 rows, rows represent directions: both (AB-BA), clockwise (AB), cclockwise (BA)
                                                columns represent doorways: 1 (AB), 2 (BC), 3 (CD), 4 (DA)
                                                doormat is true when the door is closed in a direction. If the door is closed in both directions all rows will be true
                                                doormat is false when the door is open in a direction. If the door is open completely all rows will be false
- `door_states`                               = Same as doormat, but the three rows are arranged side by side (student access)
- `directory`                                 = the directory of the saved data

## Firing rate maps and dwell maps
- `aligned_all_ratemap`                       = (all data) firing rate map for the whole session, aligned to the maze so all maps can be overlaid
- `aligned_all_dwellmap`                      = (all data) dwell time map for the whole session, aligned to the maze so all maps can be overlaid
- `aligned_rotated_all_ratemap`               = (all data) firing rate map for the whole session, aligned to the maze so all maps can be overlaid
                                                rotated so closed door is at bottom (protocol 6) or flipped so all doors are closed in CW direction (protocol 7)
- `aligned_rotated_all_dwellmap`              = (all data) dwell time map for the whole session, aligned to the maze so all maps can be overlaid
                                                rotated so closed door is at bottom (protocol 6) or flipped so all doors are closed in CW direction (protocol 7)
- `aligned_forage_ratemap`                    = (foraging data only) firing rate map for the whole session, aligned to the maze so all maps can be overlaid
- `aligned_forage_dwellmap`                   = (foraging data only) dwell time map for the whole session, aligned to the maze so all maps can be overlaid
- `aligned_rotated_forage_ratemap`            = (foraging data only) firing rate map for the whole session, aligned to the maze so all maps can be overlaid
                                                rotated so closed door is at bottom (protocol 6) or flipped so all doors are closed in CW direction (protocol 7)
- `aligned_rotated_forage_dwellmap`           = (foraging data only) dwell time map for the whole session, aligned to the maze so all maps can be overlaid
                                                rotated so closed door is at bottom (protocol 6) or flipped so all doors are closed in CW direction (protocol 7)
- `aligned_goal_ratemap`                      = (goal-directed data only) firing rate map for the whole session, aligned to the maze so all maps can be overlaid
- `aligned_goal_dwellmap`                     = (goal-directed data only) dwell time map for the whole session, aligned to the maze so all maps can be overlaid
- `aligned_rotated_goal_ratemap`              = (goal-directed data only) firing rate map for the whole session, aligned to the maze so all maps can be overlaid
                                                rotated so closed door is at bottom (protocol 6) or flipped so all doors are closed in CW direction (protocol 7)
- `aligned_rotated_goal_dwellmap`             = (goal-directed data only) dwell time map for the whole session, aligned to the maze so all maps can be overlaid
                                                rotated so closed door is at bottom (protocol 6) or flipped so all doors are closed in CW direction (protocol 7)
- `compartment_maps_all`                      = (all data) 4 columns, firing rate map for each compartment (A-D), cut to the boundary of each compartment
- `doorway_maps_all`                          = (all data) 8 columns, firing rate map for each doorway, separated by side (AB BC CD DA BA CB DC AD), cut to the boundary of the compartment the door way is in (pixels > 25cm from doorway are NaN)
- `compartment_maps_forage`                   = (foraging data only) 4 columns, firing rate map for each compartment (A-D), cut to the boundary of each compartment
- `doorway_maps_forage`                       = (foraging data) 8 columns, firing rate map for each doorway, separated by side (AB BC CD DA BA CB DC AD), cut to the boundary of the compartment the door way is in (pixels > 25cm from doorway are NaN)
- `compartment_maps_goal`                     = (goal-directed data only) 4 columns, firing rate map for each compartment (A-D), cut to the boundary of each compartment
- `doorway_maps_goal`                         = (goal-directed data only) 8 columns, firing rate map for each doorway, separated by side (AB BC CD DA BA CB DC AD), cut to the boundary of the compartment the door way is in (pixels > 25cm from doorway are NaN)

## Field and cell typing data
- `place_field_data`                          = for all place fields in this part (per row): the part number, xy centroid, xy weighted centroid, area in pixels
- `all_fields`                                = field data for all sessions combined into one matrix and columns added:
                                                estimated place field tracked across sessions, weighted centroid and centroid rotated so closed door is at bottom
- `cell_type_name`                            = the type of cell as a string i.e. 'pyramidal','place_cell','interneuron'
- `cell_type_itgr`                            = the type of cell as an integer i.e. pyramidal = 1, place cell = 2, interneuron = 3
- `cell_type_info`                            = the data used to determine the cell type [width of waveform, firing rate, spatial information, 95th percentile of spatial information shuffle]
- `place_field_data_chulls`                   = M x 1 cell array, each cell corresponds to a place field in place_field_data, XY coordinates of field convexhull (to overlay aligned_forage_ratemap)
- `all_chulls`                                = All of the place field convexhulls for a cell in one matrix
- `cell_type_sess`                            = The cell type in cell_type_itgr repeated for all sessions (for easy indexing)
  
## Correlation matrices

- `session_corr_mat_all`                      = (all data) correlation matrix for correlations between session firing rate maps (i.e. aligned_all_ratemap)
- `session_corr_mat_forage`                   = (foraging data only) correlation matrix for correlations between session firing rate maps (i.e. aligned_forage_ratemap)
- `session_corr_mat_goal`                     = (goal-directed data only) correlation matrix for correlations between session firing rate maps (i.e. aligned_goal_ratemap)
- `compartment_corr_mat_all`                  = (all data) correlation matrix for correlations between compartment firing rate maps (i.e. compartment_maps_all)
- `compartment_corr_proximity_all`            = (all data) 6 columns
                                                1-3 mean correlation between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean correlation between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `compartment_corr_mat_forage`               = (foraging data only) correlation matrix for correlations between compartment firing rate maps (i.e. compartment_maps_forage)
- `compartment_corr_proximity_forage`         = (foraging data only) 6 columns
                                                1-3 mean correlation between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean correlation between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `compartment_corr_mat_goal`                 = (goal-directed data only) correlation matrix for correlations between compartment firing rate maps (i.e. compartment_maps_goal)
- `compartment_corr_proximity_goal`           = (goal-directed data only) 6 columns
                                                1-3 mean correlation between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean correlation between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_corr_mat_all`                      = (all data) correlation matrix for correlations between doorway firing rate maps (i.e. compartment_maps_goal)
- `doorway_corr_proximity_all`                = (all data) 6 columns
                                                1-3 mean correlation between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean correlation between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_corr_mat_forage`                   = (foraging data only) correlation matrix for correlations between doorway firing rate maps (i.e. compartment_maps_goal)
- `doorway_corr_proximity_forage`             = (foraging data only) 6 columns
                                                1-3 mean correlation between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean correlation between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_corr_mat_goal`                     = (goal-directed data only) correlation matrix for correlations between doorway firing rate maps (i.e. compartment_maps_goal)
- `doorway_corr_proximity_goal`               = (goal-directed data only) 6 columns
                                                1-3 mean correlation between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean correlation between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `session_fuhs_mat_all`                      = (all data) matrix for fuhs remapping index between session firing rate maps (i.e. aligned_all_ratemap)
- `session_fuhs_mat_forage`                   = (foraging data only) matrix for fuhs remapping index between session firing rate maps (i.e. aligned_forage_ratemap)
- `session_fuhs_mat_goal`                     = (goal-directed data only) matrix for fuhs remapping index between session firing rate maps (i.e. aligned_goal_ratemap)
- `compartment_fuhs_mat_all`                  = (all data) matrix of fuhs remapping comparisons between compartment firing rate maps (i.e. compartment_maps_all)
- `compartment_fuhs_proximity_all`            = (all data) 6 columns
                                                1-3 mean fuhs remapping comparisons between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean fuhs remapping comparisons between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `compartment_fuhs_mat_forage`               = (foraging data only) matrix of fuhs remapping comparisons between compartment firing rate maps (i.e. compartment_maps_forage)
- `compartment_fuhs_proximity_forage`         = (foraging data only) 6 columns
                                                1-3 mean fuhs remapping comparisons between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean fuhs remapping comparisons between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `compartment_fuhs_mat_goal`                 = (goal-directed data only) matrix of fuhs remapping comparisons between compartment firing rate maps (i.e. compartment_maps_goal)
- `compartment_fuhs_proximity_goal`           = (goal-directed data only) 6 columns
                                                1-3 mean fuhs remapping comparisons between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean fuhs remapping comparisons between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_fuhs_mat_all`                      = (all data) fuhs remapping comparisons between doorway firing rate maps (i.e. compartment_maps_all)
- `doorway_fuhs_proximity_all`                = (all data) 6 columns
                                                1-3 mean fuhs remapping comparisons between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean fuhs remapping comparisons between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_fuhs_mat_forage`                   = (foraging data only) fuhs remapping comparisons between doorway firing rate maps (i.e. compartment_maps_forage)
- `doorway_fuhs_proximity_forage`             = (foraging data only) 6 columns
                                                1-3 mean fuhs remapping comparisons between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean fuhs remapping comparisons between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_fuhs_mat_goal`                     = (goal-directed data only) fuhs remapping comparisons between doorway firing rate maps (i.e. compartment_maps_goal)
- `doorway_fuhs_proximity_goal`               = (goal-directed data only) 6 columns
                                                1-3 mean fuhs remapping comparisons between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean fuhs remapping comparisons between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]

## Firing rate matrices

- `session_frate_mat_all`                      = (all data) matrix of absolute firing rate differences between session firing rate maps (i.e. aligned_all_ratemap)
- `session_frate_mat_forage`                   = (foraging data only) matrix of absolute firing rate differences between session firing rate maps (i.e. aligned_forage_ratemap)
- `session_frate_mat_goal`                     = (goal-directed data only) matrix of absolute firing rate differences between session firing rate maps (i.e. aligned_goal_ratemap)
- `compartment_frate_mat_all`                  = (all data) matrix of absolute firing rate differences between compartment firing rate maps (i.e. compartment_maps_all)
- `compartment_frate_proximity_all`            = (all data) 6 columns
                                                1-3 mean absolute firing rate differences between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean absolute firing rate differences between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `compartment_frate_mat_forage`               = (foraging data only) matrix of absolute firing rate differences between compartment firing rate maps (i.e. compartment_maps_forage)
- `compartment_frate_proximity_forage`         = (foraging data only) 6 columns
                                                1-3 mean absolute firing rate differences between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean absolute firing rate differences between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `compartment_frate_mat_goal`                 = (goal-directed data only) matrix of absolute firing rate differences between compartment firing rate maps (i.e. compartment_maps_goal)
- `compartment_frate_proximity_goal`           = (goal-directed data only) 6 columns
                                                1-3 mean absolute firing rate differences between compartments near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean absolute firing rate differences between compartments far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_frate_mat_all`                      = (all data) absolute firing rate differences between doorway firing rate maps (i.e. compartment_maps_all)
- `doorway_frate_proximity_all`                = (all data) 6 columns
                                                1-3 mean absolute firing rate differences between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean absolute firing rate differences between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_frate_mat_forage`                   = (foraging data only) absolute firing rate differences between doorway firing rate maps (i.e. compartment_maps_forage)
- `doorway_frate_proximity_forage`             = (foraging data only) 6 columns
                                                1-3 mean absolute firing rate differences between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean absolute firing rate differences between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
- `doorway_frate_mat_goal`                     = (goal-directed data only) absolute firing rate differences between doorway firing rate maps (i.e. compartment_maps_goal)
- `doorway_frate_proximity_goal`               = (goal-directed data only) 6 columns
                                                1-3 mean absolute firing rate differences between doorways near to door change [between Sa and Sb, Sb and Sc, Sc and Sd]
                                                4-6 mean absolute firing rate differences between doorways far to door change [between Sa and Sb, Sb and Sc, Sc and Sd]

# Examples

```matlab
%% #################### Example 1, extract all place cell firing rate maps in each protocol type
    % protocol 6 (one door closed both ways)
    idx = sdata_big.cell_type_itgr==2 & sdata_big.phase==6; % an index for all place cells (cell_type_itgr==2) in the closed door protocol (sdata_big.phase==6)
    all_maps6 = cell(1,5);
    for ss = 1:5
        all_maps6{ss} = cat(3,sdata_big.aligned_all_ratemap{ idx & sdata_big.partn==ss }); % extract ratemaps only for place cells in protocol 6 but also only in part ss
    end
    
    % protocol 7 (all doors closed both ways)
    idx = sdata_big.cell_type_itgr==2 & sdata_big.phase==7; % an index for all place cells (cell_type_itgr==2) in the closed door protocol (sdata_big.phase==6)
    all_maps7 = cell(1,5);
    for ss = 1:5
        all_maps7{ss} = cat(3,sdata_big.aligned_all_ratemap{ idx & sdata_big.partn==ss }); % extract ratemaps only for place cells in protocol 6 but also only in part ss
    end

    % now all_maps6 is a 1 x 5 cell array, each column corresponds to a session (Sa, Sb, Sc, Sd, Se)
    % remember that sessions Sa, Sb and Se always have all doors open
    % within each cell there are N x M x C matrices where N x M are the dimensions of the firing rate maps, C is the number of place cells
    % all_maps7 contains the same information for protocol 7 (one-way)
    % These maps are taken 'as is', they are not sorted by closed door position etc
    % Instead, the same process can be applied to (for instance) aligned_rotated_all_ratemap
    % Those maps are rotated so the closed door is always at the bottom (protocol 6) or flipped so all doors are closed in CW direction (protocol 7)

%% #################### Example 2, plot position data and spikes for every session for a cell
    close all;
    % choose which cell we want to look at
    cell_unique_id = 'r35.31122019.1.1'; % just a random cell I picked, if this crashes use the next line instead
    % cell_unique_id = sdata_big.uci{1}; % this just takes whatever cell is listed first in sdata_big
    
    % to get the correct position data we need to know which session this cell was recorded in
    rat = sdata_big.rat{ismember(sdata_big.uci,cell_unique_id) & sdata_big.partn==1}; % get the rat the cell was recorded from
    date = sdata_big.date(ismember(sdata_big.uci,cell_unique_id) & sdata_big.partn==1); % get the date of the session it was recorded in
    % with these two pieces of information we can index into bdata_big which holds the session information
    % like position data
   
    % run through and plot each session    
    figure
    for ss = 1:5 % there are 5 parts or sessions we want to plot: Sa, Sb, Sc, Sd, Se
        subplot(1,5,ss)
            pos = bdata_big.positions{ismember(bdata_big.rat,rat) & ismember(bdata_big.date,date) & ismember(bdata_big.partn,ss)}; % using the rat and date information we can index into bdata_big
            % this is basically getting an index for [rat & date & session/part]
            pox = pos(:,1); % position data x for this rat, date and part
            poy = pos(:,2); % position data y for this rat, date and part
            pot = pos(:,3); % position data z for this rat, date and part
            
            spike_index_for_this_part = sdata_big.part_spike_index{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)}; % the spike index is just the nearest neighbour in pox, poy and pot for every spike
            % importantly this index is just for the position data for this part
            % there is another index called 'spike index' but this is probably not useful in this context
            spx = pox(spike_index_for_this_part); % spikes positions in x for this rat, date and part
            spy = poy(spike_index_for_this_part); % spikes positions in y for this rat, date and part
            spt = sdata_big.spike_times{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)}; % spike times (we won't use these here but I have added them in case they are useful)
            
            plot(pox,poy,'k'); hold on; % plot the position data
            plot(spx,spy,'r.','MarkerSize',18); % plot the spike data
            daspect([1 1 1]) % keep the axis ratio equal
            axis xy % plot in XY as this is the reference frame of the data
            title(sdata_big.part{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)}); % add a title to show the session
    end

%% #################### Example 3, plot firing rate map for every session for a cell
    % choose which cell we want to look at
    cell_unique_id = 'r35.31122019.1.1'; % just a random cell I picked, if this crashes use the next line instead
    % cell_unique_id = sdata_big.uci{1}; % this just takes whatever cell is listed first in sdata_big

    % run through and plot each session    
    figure
    for ss = 1:5 % there are 5 parts or sessions we want to plot: Sa, Sb, Sc, Sd, Se
        subplot(3,5,ss)
            map = sdata_big.aligned_all_ratemap{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)};
            im = imagesc(map);
            set(im,'alphadata',~isnan(map));
            daspect([1 1 1]) % keep the axis ratio equal
            axis xy % plot in XY as this is the reference frame of the data
            title([sdata_big.part{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)} ' (all data)']); % add a title to show the session
            
        subplot(3,5,ss+5)
            map = sdata_big.aligned_forage_ratemap{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)};
            im = imagesc(map);
            set(im,'alphadata',~isnan(map));
            daspect([1 1 1]) % keep the axis ratio equal
            axis xy % plot in XY as this is the reference frame of the data
            title([sdata_big.part{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)} ' (foraging data)']); % add a title to show the session
                        
        subplot(3,5,ss+10)
            map = sdata_big.aligned_goal_ratemap{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)};
            im = imagesc(map);
            set(im,'alphadata',~isnan(map));
            daspect([1 1 1]) % keep the axis ratio equal
            axis xy % plot in XY as this is the reference frame of the data
            title([sdata_big.part{ismember(sdata_big.uci,cell_unique_id) & ismember(sdata_big.partn,ss)} ' (goal data)']); % add a title to show the session
    end

%% #################### Example 4, plot every trial (bell to bell) in every part for a session
    session_to_plot = {'r35',31122019}; % rat name, date as in bdata_big, if this crashes use the next line
%     session_to_plot = {bdata_big.rat{1},bdata_big.date{1}}; % just take the first session 

    for pp = 1:5
        figure('position',[100 100 1400 800])
        
        % sort out trial data
        tdat = bdata_big.correct_bell_index{ismember(bdata_big.rat,session_to_plot{1}) & ismember(bdata_big.date,session_to_plot{2}) & ismember(bdata_big.partn,pp)};
        tnum = size(tdat,1);      
        % trial_data columns:
        % column 1: 1st bell time (trial start)
        % column 2: 2nd bell time (trial end)
        % column 3: 1st compartment (box at start/when bell happens)
        % column 4: 2nd compartment (box at end/rewarded box)   
        % column 5: error messages as a formatted string
        % column 6: 1st foraging compartment
        % column 7: 1st foraging correct or not
        % column 8: Time between bell and foraging in the correct compartment                
        % column 9: Time between bell and moving to a new (any) compartment
        % column 10: Average speed 1s before the bell
        % column 11: Average speed 1s after the bell
        % column 12: 1st door push choice after the bell
        % column 13: Time of the 1st door push choice after the bell
        % column 14: Time between the bell and 1st door push
        % column 15: Shortest path the rat could have taken to correct box
        % column 16: Optimal door the rat should have pushed on
        % column 17: 1st push optimal or not 
        stimes = cell2mat(tdat(:,1));
        ptimes = cell2mat(tdat(:,13));       
        etimes = cell2mat(tdat(:,2));        

        pox = double(bdata_big.positions{ismember(bdata_big.rat,session_to_plot{1}) & ismember(bdata_big.date,session_to_plot{2}) & ismember(bdata_big.partn,pp)}(:,1));
        poy = double(bdata_big.positions{ismember(bdata_big.rat,session_to_plot{1}) & ismember(bdata_big.date,session_to_plot{2}) & ismember(bdata_big.partn,pp)}(:,2));
        pot = double(bdata_big.positions{ismember(bdata_big.rat,session_to_plot{1}) & ismember(bdata_big.date,session_to_plot{2}) & ismember(bdata_big.partn,pp)}(:,3));
        pob = double(bdata_big.behaviour_index{ismember(bdata_big.rat,session_to_plot{1}) & ismember(bdata_big.date,session_to_plot{2}) & ismember(bdata_big.partn,pp)}(:,1));
        evdat = bdata_big.event_flag_values{ismember(bdata_big.rat,session_to_plot{1}) & ismember(bdata_big.date,session_to_plot{2}) & ismember(bdata_big.partn,pp)};
        evtat = bdata_big.event_flag_times{ismember(bdata_big.rat,session_to_plot{1}) & ismember(bdata_big.date,session_to_plot{2}) & ismember(bdata_big.partn,pp)};

        for tt = 1:tnum
            subplot(2,6,tt);
                tindx2 = pot>stimes(tt)-2 & pot<stimes(tt);            
                tindx = pot>stimes(tt) & pot<etimes(tt);
                [~,pindx] = min(abs(pot-ptimes(tt)));
                [~,sindx] = min(abs(pot-stimes(tt)));
                vindx = find(evtat>stimes(tt)-2 & evtat<etimes(tt)); 
                
                p1 = plot(pox(tindx2),poy(tindx2),'Color',[.5 .5 .5]); hold on; % positions                
                p2 = plot(pox(sindx),poy(sindx),'go','MarkerSize',9); hold on; % bell sound     
                
                cline(pox(tindx),poy(tindx),[],pob(tindx)); hold on; % positions coloured by behaviour

                colormap(gca,[[1 0 0];[0 0 1]])
                mapn = colormap(gca);
                p6a = plot(0,0,'Color',mapn(1,:));
                p6b = plot(0,0,'Color',mapn(2,:));

                p3 = plot(pox(pindx),poy(pindx),'bo','MarkerSize',9); hold on; % first door push      
                for vv = 1:length(vindx)
                    enow = knnsearch(pot,evtat(vindx(vv))); % there are much faster methods but for simplicity I'm using this here
                    text(pox(enow),poy(enow),evdat{vindx(vv)},'FontSize',8,'Color','m','HorizontalAlignment','center','VerticalAlignment','middle')
                    p4 = plot(pox(enow),poy(enow),'mo','MarkerSize',12);
                end

                % Inner maze outline - coloured according to 1st door push
                %p5 = plot(epoly2(:,1),epoly2(:,2),'Color','k'); hold on; % environment                    

                % Outer maze outline - coloured according to 1st foraging
                if isnan( tdat{tt,7} )
                    text(0.95,-0.05,'Foraging missing','FontSize',6,'HorizontalAlignment','right','Color','k','Units','normalized','VerticalAlignment','top');                    
                elseif tdat{tt,7}
                    text(0.95,-0.05,'Foraging correct','FontSize',6,'HorizontalAlignment','right','Color','g','Units','normalized','VerticalAlignment','top');                    
                else
                    text(0.95,-0.05,'Foraging incorrect','FontSize',6,'HorizontalAlignment','right','Color','r','Units','normalized','VerticalAlignment','top');                    
                end                
                
                daspect([1 1 1]);
                axis xy off
                buff = 3;
                axis([min(pox(:,1))-buff, max(pox(:,1))+buff, min(poy(:,1))-buff, max(poy(:,1))+buff])
                
                comps = {'A','B','C','D'};
                if ~isnan( tdat{tt,3} ) && ~isnan( tdat{tt,4} )
                    tstring = sprintf('%s -> %s (opt=%s, rat=%s)',comps{tdat{tt,3}},comps{tdat{tt,4}},tdat{tt,16},tdat{tt,12});
                    title(tstring);
                else
                    title('Error');                    
                end        
                
                if ~isempty(tdat{tt,5})
                    text(0.5,-0.2,tdat{tt,5},'FontSize',5,'HorizontalAlignment','center','Units','normalized','VerticalAl','top')
                end
                
                if tt==1
                    str = sprintf('G = groom,   U = rear,   V = VTE\n1 = AB push,   2 = BA push,   3 = BC push,   4 = CB push,   5 = CD push,   6 = DC push,   7 = DA push,   8 = AD push\nA = bell box a,   B = bell box b,   C = bell box c,   D = bell box d');                    
                    text(8,-0.7,str,'FontSize',6,'HorizontalAlignment','right','Units','normalized','Color','m','VerticalAl','top')                    
                end
                
                if tt==1
                    leg = legend([p1,p6a,p6b,p2,p3,p4],{'Path 2s before bell','Goal directed','Foraging','Bell sound','1st door push','Event flag'});
                    set(leg,'Position',get(leg,'Position')+[0 -0.25 0 0]);
                    legend boxoff
                end
        end
    end
```



















