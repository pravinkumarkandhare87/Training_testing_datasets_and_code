# Training_testing_datasets_and_code
  Datasets used for the manuscript "Deep learning for location prediction on noisy trajectories"
  
  Training dataset folder has four training sets LTD, CTD, PTD and MTD .
  Total numbers of 100,000 trajectories are present in each training set (LTD, CTD, PTD). Whereas, MTD training set has 300,000 trajectories.
  The seven (x,y) location on each trajectory is stored in a row of csv file for each training set in the following format.
  x1 | y1 | x2 | y2 | x3 | y3 | x4 | y4 | x5 | y5 | x6 | y6 | x7 | y7  (| represent the column in csv file)
  
  Similarly, the seven (x,y) location on each trajectory is stored in a row of csv file for each testing set in above format.
  Total numbers of 100,000 trajectories are present in each testing set LTD, CTD, PTD and MTD.
  
  The MATLAB code files to generate these sets are present in "Code_to_generate_training _and_testing_datasets" folder 
