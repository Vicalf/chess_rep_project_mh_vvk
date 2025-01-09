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
   Once you runned the two previous commands, you can run the analysis on Linux (because Windows file system has different syntax) :
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
  | opponent type |[LLM, chess engine, human]|What docoherentes happen if 2 LLM play together ? |
  | chess engine       | Stockfish, AlphaZero, Komodo Chess  | May not play the same move, and trigger different reactions |
  | ELO / real level of chess engine | [0 -> 3000] | Better opponent may make LLM play better moves |
  | temperature        | [0 -> 1]             | May increase number of illegal moves        
  |way to manage LLM illegal move | [correct the illegal move, consider LLM defeat] | may learn to the LLM not to make some mistakes during the same game                 |coherent

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
1. **Setting Up the Environment**  
  Given you followed step to reproduce the experiment, you should have the image named project_repro, which will be used in images for replication. You then only have to build images databuild and jupyter-replication

     ```bash
     docker build . -t databuild -f ./databuild.dockerfile
     docker build . -t jupyter-replication -f ./replication.Dockerfile
     export OPENAI_API_KEY=[[YOUR OPENAI API KEY]]
     ```
2. **Data building** 

  You can generate new data to be added to previously generated.
    ```bash
    docker run -e OPENAI_API_KEY=$OPENAI_API_KEY -e outputDir=games-repro/ -v $(pwd)/games-repro:/app/games-repro databuild
    ```
  This will execute gptchess/gpt-experiment.py. Currently, it generates 11 new games, one for each tested temperature (0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9 and 1.0)
  Each parameter can be edited in the file gptchess/gpt-experiment.py : stockfish level, temperature, etc.

3. **Replication analysis execution**

  Analysis can be launched with the command:
    ```bash
    docker run -v $(pwd)/output:/output jupyter-replication
    ```
  You should find the analysis results in the output/replication folder. There should be two relevant elements :
  - analysis_files folder contains all medias generated in the analysis notebook
  - analysis.md file shows the results of notebook execution.

### Encountered Issues

1. **Docker execution**

For an unknown reason, the execution of the databuild container only displays the standard output after it has fully completed, including the "print" statements executed during the process.
For several weeks, we thought it wasn't working since it took about ten minutes to show any results.

2. **Game configurations multiplicity**

In order to conduct a consistent analysis, we thought that we needed games coherent, meaning the data used shall only vary on the studied criteria (here, the temperature)
Given that the existent dataset contains games with multiple factors varying, we couldn't use all these games. We thus extracted only games where random_engine = false, PGNpromt is basePGNprompt, white player is stockfish and black player is gpt3.5 turbo. This way, we ensure that the player color, the randomness, the PGN prompt, and the adversary don't influence the results.
The only variable that remains is the skill level of Stockfish : Stockfish has different elo depending on the game. We think that this factor will not influence the result too much since the elo score computation use the mean of elo scores of adversaries.

### Impact of the temperature on the illegal moves
- From the cell [13], we have :

| temperature |  percentage of games with illegal moves |
|:------------|----------------------------------------:|
| 0.0         |                                  23.61% |
| 0.1         |                                  17.86% |
| 0.2         |                                  35.71% |
| 0.3         |                                  17.86% |
| 0.4         |                                  53.57% |
| 0.5         |                                  39.29% |
| 0.6         |                                  35.71% |
| 0.7         |                                  57.14% |
| 0.8         |                                  66.67% |
| 0.9         |                                  59.57% |
| 1.0         |                                  66.67% |

We clearly see that the higher the temperature is set, the more illegal move the LLM give

When we look more deeply into the illegal moves made by the LLM, we see that, regardless of the temperature, the majority of these moves are "1-0" These could arguably not be considered illegal moves per se but rather a forfeit by the LLM (Black player). This hypothesis is further confirmed in cell [15], where we observe that in all the games where these "1-0" outcomes occurred, Stockfish appeared to have the advantage (121 cases out of 123).

### Impact of the temperature on the ELO rating

Given the results in the last cell, we see that the two computations are consistent, (curves are almost one on the other). However, it seems that the elo is clearly decreasing when the temperature increase higher than 0.2. It seems then that the elo of gpt-3.5-turbo-instruct is better with some temperature (around t = 0.2). 
However we should be careful and try to redo the experience with same number of game for each Stockfish skill level with each temperature, since for now, t=0.0 have many more games with stockfish varying skill levels 

## Conclusion

### Discussion

Through this project, we successfully reproduced key findings from Mathieu Acher's study on evaluating GPT models in chess experiments. Our work confirmed the reproducibility of the original study's results, particularly the Elo ratings and the assessment of illegal moves, despite some initial challenges such as dependency management and Docker setup.

The replication analysis revealed that the temperature parameter significantly impacts both the frequency of illegal moves and the Elo performance of GPT-3.5-turbo-instruct. Higher temperatures led to an increased rate of illegal moves, often manifesting as "1-0" forfeits rather than rule violations, further supporting the hypothesis of GPT's difficulty under adversarial pressure. Conversely, Elo ratings were highest at lower temperatures, peaking around 0.2 before decreasing as temperature increased.

While our results align with the original findings, certain limitations, such as variability in Stockfish skill levels and unequal game counts across temperature settings, highlight areas for improvement in experimental design. Ensuring consistent conditions across all tests would allow for more robust conclusions.

Overall, this work demonstrates the importance of reproducibility and replicability in machine learning research. By validating Acher's findings and exploring alternative configurations, we provide valuable insights into the behavior of GPT models in chess experiments and contribute to the broader discourse on experimental reliability in AI studies.

### Limitation of the Subject

The chosen article is well-detailed and, as a result, highly reproducible. The inclusion of tools such as the Jupyter notebook significantly facilitated the reproduction process, allowing us to navigate the experiments with relative ease. However, we encountered notable challenges, particularly when it came to drawing comprehensive conclusions, especially during the replication phase.

A significant limitation lies in the absence of a singular, clearly defined target result. Instead, the study produces multiple diverse outputs that need to be analyzed. While this provides a broader understanding of the subject, it also complicates the task of systematically comparing individual results across different factors. This is particularly critical in the replication phase, where the objective is to explore the variability of outcomes under different conditions. The lack of a unified benchmark makes it difficult to fully assess the impact of individual factors or reach definitive conclusions.

These challenges underline the importance of designing experiments with clear, interpretable metrics that facilitate consistent comparisons. While the article provided an excellent foundation for reproduction, future work could benefit from a more structured framework to evaluate results, particularly when analyzing the effects of various parameters in replication studies.