/* Copyright 2017 Karl-Philipp Richter

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

/* An angle which can be constructed from multiple parts of recyled wood consisting of two sides (lavender color) and two support parts (yellow) which are screwed into the wall and the object to hold */

/* The angle in degrees
*/
angle = 45;
/* The effective length of the wall support side in mm (the length of the opposite support will be calculated based on angle.
*/
length = 140;
/* The width of the support in mm.
*/
support_width = 30;
/* The depth of the support in mm.
*/
support_depth = 30;
/* The thickness of the sides in mm.
*/
side_thickness = 10;
/* The diameter of the screw hole in mm.
*/
screw_hole_diameter = 6;

support_length = length-2*support_depth;
    //need to substract in order to make supports less visible
module support() {
    difference() {
        cube([support_depth, support_width, support_length]);        
        //screw holes
        translate([0, support_width/2, support_length/3]) {
            rotate([0,90,0]) {
                cylinder(support_depth, d=screw_hole_diameter, center=false);
            }
        }
        translate([0, support_width/2, support_length/3*2]) {
            rotate([0,90,0]) {
                cylinder(support_depth, d=screw_hole_diameter, center=false);
            }
        }
    }
}
translate([0, side_thickness, support_depth]) {
    support();
}
translate([support_depth, side_thickness, length]) {
    rotate([0,90,0]) {
        support();
    }
}

module side() {
    polyhedron( [[0,0,0], //bottom
        [length, 0,length], //top right
        [0,0,length], //top //left
        [0,side_thickness,0], //bottom
        [length,side_thickness, length], //top right
        [0,side_thickness,length] //top left
    ],
        [[0,2,1], //front
        [5,4,1,2], //top
        [5,2,0,3], //wall support back
        [0,1,4,3], //angle front
        [5,3,4] //back
    ]);
}

color("Lavender") {
    side();
        //side front
    translate([0,side_thickness+support_width,0]) {
        side();
    }
        //side back
}
    //sides
