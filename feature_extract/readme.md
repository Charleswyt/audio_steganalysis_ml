## Feature Extraction
+ **feature_adotp**<br>
API: features = feature_adotp(matrix, T)<br>
Intro:<br>
1. Extract the QMDCT coefficients matrix
2. Calculate the first order of abs difference of QMDCT coefficients matrix in row direction, AQD<sub>m,n</sub> = |Q<sub>m+1,n</sub> - Q<sub>m,n</sub>|
3. Calculate the OTP(One-step Transition Probabilities) of inter-frame and intra-frame, P<sub>AD_Inter</sub> and P<sub>AD_Intra</sub>.
4. Feature Selection

+ **feature_d2ma**<br>
API: features = feature_d2ma(matrix, T)
Intro:<br>
1. Extract the QMDCT coefficients matrix
2. Calculate the mean value, standard deviation, skewness, and kurtosis of subband signals
3. Calculate ANJD and OPT of QMDCT coefficients matrix in row and col direction

+ **feature_i2c**<br>
API: features = feature_i2c(matrix, T)
Intro:<br>
1. Extract the QMDCT coefficients matrix
2. Get abs coefficients matrix
3. 2 x 2 block down-sampling of QMDCT coefficients matrix, four sub-matrices will be created
4. Calculate the OPT of QMDCT coefficients matrix, abs coefficients matrix and all sub-matrices in row and col direction

+ **feature_jpbc**<br>
API: features = feature_jpbc(matrix, T)
Intro:<br>
1. Extract the QMDCT coefficients matrix
2. Calculate the difference matrices through each HPF
3. Obtain 2 x 2 and 4 x 4 block-wise sub-matrices of QMDCT coefficient matrix and all difference matrices in the way of the down-sampling
4. Calculate the OTP of the matrices on the point-wise and multi-scale block-wise level in the horizontal and vertical directions
5. Feature Selection

+ **feature_mdi2**<br>
API: features = feature_mdi2(matrix, T)
Intro:<br>
1. Extract the QMDCT coefficients matrix
2. Calculate
   + the first order of QMDCT coefficients matrix in row direction (inter-frame)
   + the first order of QMDCT coefficients matrix in col direction (intra-frame)
   + the second order of QMDCT coefficients matrix in row direction (inter-frame)
   + the second order of QMDCT coefficients matrix in col direction (intra-frame)
3. Calculate the OTP(One-step Transition Probabilities) and ANJD(Accumulative Neighboring Joint Density) of each matrix
   
+ **feature_occurance**<br>
API: features = feature_occurance(matrix, T)
Intro:<br>
1. Extract the QMDCT coefficients matrix
2. Calculate the co-occurance matrices of QMDCT coefficients matrix in 0, 45, 90, 135 direction
3. Calculate the feature of co-occurance matrices

### How to use
features = feature_extraction(matrix, feature_type, T)
+ **matrix**: QMDCT coefficients matrix
+ **feature_type**: type of features (ADOTP, D2MA, I2C, MDI2, JPBC, Occurance)
+ **T**: threshold value for truncation