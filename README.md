# 4-rooms Dataset

Matlab pre-processing tools for the 4-rooms dataset.

## 4-rooms experiment

[describe the experiment here...]

## Original dataset

The original dataset consists in 2 .mat files. 

These two files contain respectively the behavioural and the neural data collected during the experiment in the form of matlab tables. 

Accessing the data in this form is not practical. This branch contains the matlab code to transform the original 4-rooms dataset into a more accessible format. 

In the new format, data are stored as .csv files in folders organised according to a specific logic.

### Behavioural data

Original behavioural data are stored in the `quaddata_bdata_big.mat` file as matlab table. In the new format, data are organised as follows:

```bash
data/processed/behaviour
├── rat1
│   ├── session1
│   .
│   .
│   └── sessionN
.
.
└── ratL
    ├── session1
    .
    .
    └── sessionN
```
Each session subfolder corresponds to a row of the original matlab table. In each session subfolder there are as many .csv files as the number of columns in the table.

### Neural data

Original neural data are stored in the `quaddata_sdata_big.mat` file as matlab table. In the new format, data are organised as follows:

```bash
data/processed/neural
├── rat1
│   ├── session1
│   │   ├── cell1
│   │   .
│   │   .
│   │   └── cellM
│   │
│   └── sessionN
│       ├── cell1
│       .
│       .
│       └── cellM

.
.
└── ratL
    ├── session1
    │   ├── cell1
    │   .
    │   .
    │   └── cellM
    .
    .
    └── sessionN
        ├── cell1
        .
        .
        └── cellM
```

Each session subfolder corresponds to a row of the original matlab table. In each session subfolder there are as many subfolders as the number of cells in the session. Each cell subfolder contains as many .csv files as the number of columns in the table.


## Data Processing

In order to process correctly the data, the following steps must be followed:
1. Have the raw data in the folder `./data/raw`
2. Run the `src/main.m` script using matlab
3. Run the `src/fix_folders.sh` script using bash

### `main.m` script

The `main.m` script reads the files:

```bash
./data/raw/quaddata_bdata_big.mat
./data/raw/quaddata_sdata_big.mat
```

and writes the preprocessed data in the folders:

```bash
./data/processed/behaviour
./data/processed/neural
```

### `fix_folders.sh` script

The `fix_folders.sh` script transform the folder structure of the preprocessed data.

The new structure is:

```bash
data/newstruct_processed/
├── rat1
│   ├── session1
│   │   ├── behaviour
│   │   └── neural
│   │       ├── cell1
│   │       .
│   │       .
│   │       └── cellM
│   .
│   .
│   └── sessionN
│       ├── behaviour
│       └── neural
│           ├── cell1
│           .
│           .
│           └── cellM
.
.
└── ratL
    ├── session1
    │   ├── behaviour
    │   └── neural
    │       ├── cell1
    │       .
    │       .
    │       └── cellM
    .
    .
    └── sessionN
        ├── behaviour
        └── neural
            ├── cell1
            .
            .
            └── cellM
```

### Notes

The preprocessing excludes:
- the `graph` column of bdata_big table

