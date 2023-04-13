# ELEC340 Final-Year-Project
<font size = 4> *Vehicle-Tracking-In-Large-Area-Video* </font>

## Introduction

This project will be concerned with developing tracking algorithms for detecting and creating a track for specific vehicles through a complex urban environment. This project will use existing video simulations ([example](https://stream.liv.ac.uk/zbj9sswg)) showing complex environments where vehicles are occluded as an air vehicle moves through a city. The processing steps of the project can be seperated into three parts, which are image handling, vehicle detection and tracking.

+ **Image Handling** ——— the vehicle would move from one square of the image to the other square of image while tracking. In hence, the right square of image (time dependent) need to be load from the file.

+ **Object / Vehicle Tracking** —— the vehicle detection requires corresponding algorithms for motion detection, and the template matching method are demanded to match the corresponding features with target vehicle.

+ **Tracking** —— application of Kalman Filter and Particle Filter




## Gannt Chart
```mermaid
gantt
    dateFormat  YYYY-MM-DD

    Mataining this Gantt Chart [Zehao Ye] : 2022-09-26, 2023-05-31

    section Preparation
    Literature Review : prepare, 2022-09-26, 35d
    Preliminary Reprot Writing : report writing, 2022-10-10, 3d
    Risk Assessment and Safety forms : milestone, 2022-10-13, 0d
    Preliminary Report : crit, after report writing, 2022-10-14

    section Design & Development
    Design the Algorithm : 2022-10-17, 14d
    Image Processing Algorithm Development : 2022-10-24, 10d
    Image Processing Algorithm Testing : 2022-10-31, 10d
    Vehicle Association Algorithm Development : 2022-11-7, 14d
    Kalman Filter Algorithm Development : 2022-11-21, 14d
    Single Vehicle Tracking Algorithm Development : 2022-11-28, 10d
    Single Vehicle Tracking Algorithm Testing : 2022-12-5, 14d
    Presentation Preparation : 2022-12-10, 4d
    Single Vehicle Tracking : milestone, 2022-12-12, 0d
    Presentation : crit, 2022-12-13, 0d
    Multiple Vehicle Tracking Algorithm Development: 2023-01-09, 21d
    Multiple Vehicle Tracking Algorithm Testing: 2023-01-23, 14d


    section Testing
    Overall Testing: 2023-01-30, 35d
    Overall Modification : 2023-02-13, 35d

    section Report Writing
    Bench Inspection Writing : 2023-03-17, 2023-03-24
    Final Report Writing : 2023-03-24, 2023-04-19
    Bench Inspection : crit, 2023-03-24, 0d
    Final Report : crit, 2023-04-19, 0d

```

