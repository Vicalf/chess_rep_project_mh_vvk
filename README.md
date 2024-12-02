# Project REP : Reproductibility and Replicabily of chess experiments
*Authors : Matthieu Hillairet, Victor van  Kempen*

## Introduction



## Reproducibility

### How to Reproduce the Results
1. **Requirements**  

We used `Python 3.11`.
We wrote the list of requirements in `requirmements.txt` :
   ```
    openai   
    chess
    stockfish
    numpy <= 1.26.4
    pandas <= 1.5.0
    matplotlib
    tabulate
    jupyter
    seaborn
    scipy
   ```
OpenAI, Chess, Stockfish, Numpy, Pandas and MatPlotLib were required in the README of the original work of Mathieu Acher.
   
However, Tabulate, Seaborn et Scipy were missing in the requirements but necessary to execute the program. So that we added these to our requirements file.

Jupyter was also needed to execute the analysis notebooks and converting it into a markdown file.

Finally, the libraries version were not specified in the requirements list. The fact is that the lasts versions of numpy and pandas have deleted methods used for the analysis. 2 solutions were possible :
   - Change the source code by replacing deprecated and deleted methods by their substitute ;
   - Use an old version of these libraries.

We chose the second possibility to do the reproductibility experiments with the same code.

There wasn't specific system requirements.

2. **Setting Up the Environment**  
   - Provide instructions for using the Dockerfile to create a reproducible environment:  
     ```bash     docker build . -t project_repro ./base.Dockerfile
     docker build . -t databuild ./databuild.Dockerfile
     docker build . -t analysis ./analysis.Dockerfile
     ```

3. **Reproducing Results**  
   - Describe how to run the automated scripts or notebooks to reproduce data and analyze results:
     ```bash
     docker run databuild -e "OPENAI_API_KEY=###HERE THE SECRET###"
     docker run analysis
     ```
    
### Encountered Issues and Improvements
- Only part of the dependency were noted, and we thus needed to install more libs, and to downgrade some of them
- The selection of the right docker image was not easy, because the python image was not able to use apt and to install certain packages

### Is the Original Study Reproducible?
- The original study seems to be reproductible

## Replicability

### Variability Factors
- **List of Factors**: We identify the factor of variability described here : 
  | Variability Factor | Possible Values     | Relevance                                   |
  |--------------------|---------------------|--------------------------------------------|
  | Random Seed        | [0, 42, 123]       | Impacts consistency of random processes    |
  | Hardware           | CPU, GPU (NVIDIA)  | May affect computation time and results    |
  | Dataset Version    | v1.0, v1.1         | Ensures comparability across experiments   |

- **Constraints Across Factors**:  
  - Document any constraints or interdependencies among variability factors.  
    For example:
    - Random Seed must align with dataset splits for consistent results.
    - Hardware constraints may limit the choice of GPU-based factors.

- **Exploring Variability Factors via CLI (Bonus)**  
   - Provide instructions to use the command-line interface (CLI) to explore variability factors and their combinations:  
     ```bash
     python explore_variability.py --random-seed 42 --hardware GPU --dataset-version v1.1
     ```
   - Describe the functionality and parameters of the CLI:
     - `--random-seed`: Specify the random seed to use.
     - `--hardware`: Choose between CPU or GPU.
     - `--dataset-version`: Select the dataset version.


### Replication Execution
1. **Instructions**  
   - Provide detailed steps or commands for running the replication(s):  
     ```bash
     bash scripts/replicate_experiment.sh
     ```

2. **Presentation and Analysis of Results**  
   - Include results in text, tables, or figures.
   - Analyze and compare with the original study's findings.

### Does It Confirm the Original Study?
- Summarize the extent to which the replication supports the original study’s conclusions.
- Highlight similarities and differences, if any.

## Conclusion
- Recap findings from the reproducibility and replicability sections.
- Discuss limitations of your
