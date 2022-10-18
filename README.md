# Random forest method using whole phase curvature as a metric

Shin-ya Hasegawa and Takao Miaki

# Description 

This work introduces a randomforest method for axial positioning and characterization of a spherical particle.

# Quickstart

**(1)MATLAB Code for trained data and corresponding parameters(radius, refractive index and z potition)**
 
folder: model_mie_particle_MATLAB_code

To start the learning process, simply run 'model_r_n_z.m'.
All codes should be in the same folder. 
The traine data (model_r_n_z.txt and model_kyokuritsu.txt) are obtained.

**(2)MATLAB Code for translation of trained nine data to 1,001 data via interpolation.**

folder: 1001data_translation_MATLAB_code

To start the process, simply run 'fit_longdata_curvature.m'.
'model_r_n_z.txt' and 'model_kyokuritsu.txt'in (1) must be in this folder.
Finally, 'myData.csv' which containes 1001 curvature data is obtained.

**(3)Python Code for training and estimation.**

folder: random_forest_python_code
To start the process, simply run 'randomfor_3label.py'.
'model_r_n_z.csv'in (1) and 'myData.csv'in (2) must  in this folder.
('model_r_n_z.txt'in (1) should be translated to csv format.)
