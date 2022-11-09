# ELEC340 Final-Year-Project
<font size = 4> *Vehicle-Tracking-In-Large-Area-Video* </font>

## Introduction

This project will be concerned with developing tracking algorithms for detecting and creating a track for specific vehicles through a complex urban environment. This project will use existing video simulations ([example](https://stream.liv.ac.uk/zbj9sswg)) showing complex environments where vehicles are occluded as an air vehicle moves through a city. The processing steps of the project can be seperated into three parts, which are image handling, vehicle detection and tracking.

+ **Image Handling** ——— the vehicle would move from one square of the image to the other square of image while tracking. In hence, the right square of image (time dependent) need to be load from the file.

+ **Object / Vehicle Tracking** —— the vehicle detection requires corresponding algorithms for motion detection, and the template matching method are demanded to match the corresponding features with target vehicle.

+ **Tracking** —— application of Kalman Filter and Particle Filter




## Gannt Chart

~~~mermaid
gantt  
        dateFormat  YYYY-MM-DD
        title <Name of the project>

%%	<Name of Activity>		: crit if critical else empty,done, active or empty, reference name or empty, Start Date or dependency, End Date or Duration
        section Phase 1 Name
        Activity 1			:	 done,    des1, 2017-01-06, 2017-01-08
        Activity 2               	:	 active,  des2, 2017-01-09, 2017-01-12
        Activity 3               	:        	  des3, 2017-01-12, 5d
        Activity 4              	:         	  des4, after des3, 5d

        section Phase 2 Name
        Activity 5 			: crit, done,		2017-01-06, 24h
        Activity 6		        : crit, done, 		after des1, 2d
        Activity 7		        : crit, active, 		    3d
        Activity 8			: crit,			 	    5d
        Activity 9			:			 	    2d
        Activity 10			: 			 	    1d

        section Phase 3 Name
        Activity 11			: 	active,   a1,	after des1, 3d
        Activity 12			:			after a1  , 20h
        Activity 13			:		 doc1, 	after a1  , 48h

        section Phase 4 Name
        Activity 12			:			after doc1, 3d
        Activity 15			: 	  			    20h
        Activity 16			: 			   	    48h
~~~
<script>  
            mermaid.ganttConfig = {
                titleTopMargin:25,
                barHeight:20,
                barGap:4,
                topPadding:50,
                sidePadding:100,
                gridLineStartPadding:35,
                fontSize:11,
                numberSectionStyles:3,
                axisFormatter: [
                    // Within a day
                    ['%I:%M', function (d) {
                        return d.getHours();
                    }],
                    // Monday a week
                    ['w. %U', function (d) {
                        return d.getDay() == 1;
                    }],
                    // Day within a week (not monday)
                    ['%a %d', function (d) {
                        return d.getDay() &amp;&amp; d.getDate() != 1;
                    }],
                    // within a month
                    ['%b %d', function (d) {
                        return d.getDate() != 1;
                    }],
                    // Month
                    ['%m-%y', function (d) {
                        return d.getMonth();
                    }]
                ]
            };
</script>