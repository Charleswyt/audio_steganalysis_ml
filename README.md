# Audio Steganalysis via Machine Learning
Audio steganalysis via methods of machine learning.<br>
@ Author: Charles_wyt<br>
@ Email: wangyuntao2@iie.ac.cn <br>
Hope we can have a happy communication.

This project is a machine learning implementation of recent work for audio steganalysis, you can also design your own algoritm via this platform.

## Files
ID | File | Function 
:-:| :-:  | :-:
 1 | application     | audio steganalysis and steganographied find
 2 | batch_script    | all batch scripts for feature extraction, training, test and so on
 3 | data_processing | tools which are used for QMDCT coefficients extraction and dataset build
 4 | feature_extract | all scripts for feature extraction
 5 | plot            | scripts for figure plot
 6 | train_test      | svm and ensemble classifier
 7 | utils			 | some basic tools such as get files name and get files list

## How to use
### separation
1. Run **setup.m** and complete environmental configuration
2. For QMDCT extraction, run data_processing/batch_script/**QMDCT_extraction_batch1.bat** or **QMDCT_extraction_batch2.bat**
3. For feature extraction, run matlab scripts of batch_script/**feature_extraction_batch.m**
4. for SVM train and test, run matlab scripts of train_test/**training.m**

### Integration
1. Run **setup.m** and complete environmental configuration
2. Run **run_script1.m** or **run_script2.m**