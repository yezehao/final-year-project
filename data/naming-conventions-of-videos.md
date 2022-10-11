To input the files into MATLAB in an easier way, the files need to be renamed according to different region. According to the content in the video, the original naming conventions of videos are as follow:
|1A|1B|2A|2B|3A|3B|
|:-:|:-:|:-:|:-:|:-:|:-:|
| x_1_AA | x_1_AB | x_2_AA | x_2_AB | x_3_AA | x_3_AB |
| x_1_BA | x_1_BB | x_2_BA | x_2_BB | x_3_BA | x_3_BB |

In this naming conventions, it would be difficult for us to use MATLAB to read in the information of files. In hence, it is necessary to rename the videos. The naming conventions are shown as follow:

|1A|1B|2A|2B|3A|3B|
|:-:|:-:|:-:|:-:|:-:|:-:|
| f_n_1 | f_n_2 | f_n_3 | f_n_4 | f_n_5 | f_n_6 |
| f_n_7 | f_n_8 | f_n_9 | f_n_10 | f_n_11 | f_n_12 |

In this table, $f$ represent the field of view (fov), n represent the series number of videos, for example, the video whose file name is "movie_2_3_AA.mp4" in file of "2.5deg_fov" is renamed as "2.5_2_5.mp4". In this way, it is easier to read in information form files in MATLAB.