# Project REP : Reproductibility and Replicabily of chess experiments
*Authors : Matthieu Hillairet, Victor van Kempen*

## Introduction

This project focuses on the reproduction and replication of the research presented in the article "Debunking the Chessboard: Confronting GPTs Against Chess Engines to Estimate Elo Ratings and Assess Legal Move Abilitie" by Mathieu Acher. The original study aims to compute the Elo rating of different Generative Pretrained Transformers (GPTs) based on their performance in chess games, specifically evaluating their ability to make legal moves. The study explores how various GPT models, trained on large datasets, can be assessed using the Elo system, which is traditionally used to measure the relative skill of chess players.

Our effort aims to reproduce the results presented in the original paper by carefully following the methodologies outlined by the author, while also addressing any potential challenges in replicating the experiments. By ensuring the reproducibility of the study's results, we aim to confirm the validity of the original findings and highlight any discrepancies or improvements that could be made.

Furthermore, we aim to replicate the study under different conditions, considering various factors such as changes to the prompt or hyperparameters. This will allow us to assess the robustness and reliability of the results. The replication process will involve exploring how variations in these factors can affect the conclusions of the study, thereby testing the consistency of the findings across alternative setups.

Through this project, we hope to contribute to the broader scientific discourse on reproducibility and replicability in machine learning research, and ensure that the methods and results presented in the original study are both reliable and generalizable.

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
  Docker is needed to reproduce the experiments. As Mathieu Acher advised us, we decided to focus on the reproducibility of the analysis of the data previously generated with GPTs by Mathieu Acher. First of all, you may clone our repositary with :
    ```bash
    git clone https://github.com/Vicalf/chess_rep_project_mh_vvk.git
    ```
    Enter the folder "chess_rep_project_mh_vvk" then check there is an "output" folder.

    After that, you can build the two images needed for reproducibility. base.dockerfile creates an image with an updated-and-updated ubuntu in which python and required libraries are installed. It could last up to 5 minutes to build.

    The second one (analysis.dockerfile) aims to use the first image and execute the jupyter-notebook-to-markdown conversion.

    Make sure you don't have Docker images tagged with project_repro or analysis.

    Execute these commands at the project root :
     ```bash
     docker build . -t project_repro -f ./base.Dockerfile
     docker build . -t analysis -f ./analysis.dockerfile
     ```

3. **Reproducing Results**  
   Once you runned the two previous commands, you can run the analysis on both Windows and Linux :
   - In Windows Powershell :
     ```bash
     docker run --name jupyter_analysis -v ${PWD}\output:/output analysis
     ```
  - In Linux shell :
    ```bash
     docker run --name jupyter_analysis -v $(pwd)/output:/output analysis
    ```
  You should find the analysis results in the output folder. There should be two relevant elements :
  - analysis_files folder contains all medias generated in the analysis notebook
  - analysis.md file shows the results of original notebook execution. Every results of Mathieu Acher should be retrievable in this file.

  To re-run the analysis, you should :
  - Save in another folder the current results
  - Delete all files in `output` folder except .gitkeep
  - Remove the docker container with `docker rm jupyter_analysis`
  - Then follow the previous procedure 
    
### Encountered Issues and Improvements

Several issues were faced during the project.

Firstly, only part of the dependency were given in the README of Mathieu Acher's project. Consequenlty running the analysis was initially impossible. Thus we needed to install more libraries which we put in the `requirements.txt` file.

Moreover, some librairies were asked to install without giving clear information on the needed version. Mathieu Acher's analysis used methods which are unsupported or deprecated in the most recent libraries versions. Thus we had to downgrade some of them. In our markdown result file, we can see many warnings about the use of deprecated method. We decided not to edit the code in the reproducibility part, but it can be improved to have a clearer vision of the results.

Finally, the choice of the right docker image was difficult, because the python image was not able to use apt and to install some packages. That's why we installed python and libraries "from scratch" on the ubuntu image after updating and upgrading it.

### Is the Original Study Reproducible?

We compared analysis.md results with figures given by Mathieu Acher in his article in order to see if the experiments were reproducible.

As the final ELO values were approximately the same in the analysis.md file and Mathieu Acher's article, we concluded that the original study seemed to be reproducible.

For the reproduction phase, we also tried to regenerate the same outputs from the base prompt. However, due to the randomness of the process, this was not feasible. We decided to focus instead on generating new outputs for replication.

Even when adding new components or using alternative ones with the same format, the study remains reproducible. The analysis framework easily supports these additions, ensuring that the results obtained continue to align with the original findings and lead in the same direction.

# Replicability

### Variability Factors
- **List of Factors**:

We identify the factor of variability described here : 

  | Variability Factor | Possible Values        | Relevance                                             |
  |--------------------|---------------------   |-------------------------------------------------------|
  | LLM family         | [gpt, llama, mistral]  | May change the training process                       |
  | LLM version        | depends on family      | May change the training process                       |
  | input formulation  | "answer me with PGN notation"                    | May change the way of understanding question for LLM. |
  | game metadata given to LLM | [color played, ELO, ... (see below)] | see below depending on the metadata |
  | color played       | [white, black]         | May change the moves played by the model                          |
  | ELO prompted LLM   | [0 -> 3000]          | May influence LLM moves played (higher ELO => better moves)                |
  | ELO prompted opponent | [0 -> 3000]          | May influence LLM moves played (higher ELO => worse moves)                     |
  | player name prompted| ["", famous chess player, random] | May change the perception of the adversary and of itself |
  | winner prompted     | ["0-1","1-0","1-1"]    | May change the way of playing                         |
  | opponent type |[LLM, chess engine, human]|What does happen if 2 LLM play together ? |
  | chess engine       | Stockfish, AlphaZero, Komodo Chess  | May not play the same move, and trigger different reactions |
  | ELO / real level of chess engine | [0 -> 3000] | Better opponent may make LLM play better moves |
  | temperature        | [0 -> 1]             | May increase number of illegal moves        
  |way to manage LLM illegal move | [correct the illegal move, consider LLM defeat] | may learn to the LLM not to make some mistakes during the same game                 |

  We think that each of these factor can then affect the computation of the ELO value thus the conclusions of Mathieu Acher's study.

  We can theoretically apply all these factor to the initial experiment.

- **Constraints Across Factors**:  

**1. Interrelated Factors**  

**a) Choice of LLM and Version:**  
The selection of the LLM family (e.g., GPT, Llama, Mistral) and its version serves as a preliminary step. This choice influences all subsequent decisions regarding hyperparameters, as these parameters are inherently tied to the capabilities and constraints of the specific LLM.  

**b) Prompt Formulation:**  
Factors related to prompt design, such as the phrasing of the message (e.g., "answer me with PGN notation"), the type of interaction, and metadata (e.g., color played, ELO, or PGN metadata), are grouped together. They collectively shape how the LLM interprets and responds to the task.  

**c) Hyperparameters:**  
Parameters such as temperature, how illegal moves are managed, and the configuration of the API requests belong to this group. They directly impact the LLM's output behavior and need to be adjusted in alignment with the selected LLM family and version.  

**2. Conditional Accessibility of Factors**  

**a) Experimental Feasibility:**  
Some factors are accessible only under specific conditions. For instance, conducting experiments at scale requires the LLM to have API access to play a large number of games. This is critical for both the initial study and replication efforts.  

**b) Scalability for Replication:**  
To ensure replicability, experiments must be designed with practical execution in mind. This includes leveraging APIs for large-scale testing and ensuring that the selected configurations and factors are feasible to implement across many trials.  


### Replication Execution
1. **Instructions**  
   
     ```bash
     python gptchess/gpt-experiments.py
     ```

### Encountered Issues

1. **Docker execution**
En principe, on devrait pouvoir 

2. **Game configurations multiplicity**


### Does It Confirm the Original Study?
- Summarize the extent to which the replication supports the original study’s conclusions.
- Highlight similarities and differences, if any.

## Conclusion
- Recap findings from the reproducibility and replicability sections.
- Discuss limitations of your
