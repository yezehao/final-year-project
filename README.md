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
    Week 1 [Zehao Ye] : Literature Review based on Kalman Filter, 2022-09-26, 24d
    Week 2 [Yang Kai, Zepeng Pang] : blog2, after blog1, 7d
    Week 3 [Zepeng Pang] : blog3, after blog2, 7d
    Week 4 [Zepeng Pang] : blog4, after blog3, 5d
    Setup GitHub Pages for publishing [Minghong Xu] : milestone, 2022-02-26, 0d
    Preliminary Report : crit, after blog4, 2022-03-02

    section Project Management Documents
    Supervisor Weekly Meeting Log [Zepeng Pang] : crit, 2022-01-31, 2022-02-25
    LogBook is Git log: milestone, 2022-02-03, 0d
    Attendance Record [Minghong Xu, Zepeng Pang] : 2022-02-03, 2022-02-27
    Role Allocation (responsibility matrix) [Minghong Xu] : milestone, 2022-02-14, 0d
    Contribution to Project Deliverables [Zepeng Pang] : 2022-02-25, 2022-03-02

```
