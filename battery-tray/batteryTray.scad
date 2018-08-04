/*
OpenSCAD Script for creating a battery tray with holes for AAA or AA sized batteries.

Author:     github.com/MaxAtoms
Licence:    GNU General Public License v3.0    
*/

/********************* Configuration ******************************/

// Height of the tray
trayHeight = 12;

// Space between the bottom of the tray and the battery cylinders
bottomThickness = 1;

// Space between the holes for the batteries
spaceBetween = 3;

// Number of AA and AAA battery places (X- and Y-direction)
numAA_x = 3;
numAA_y = 4;
numAAA_x = 3;
numAAA_y = 3;

// Do you want to make a grid for AA (1) or AAA (2) batteries?
create = "AAA";

// Number of fragments for the cylinders
// Decrease the number for faster rendering time
$fn = 20;

// Diameter of a regular AA size battery
diaAA = 14.6;

// Diameter of a regular AAA size battery
diaAAA = 10.7;

/*****************************************************************/
include<roundCornersCube.scad>;

function calcSize(dia,num) = dia * num + spaceBetween * (num+1);

/*
    Create a grid of holes
    
    Args:
        dia     -   Diameter of the holes
        num_x   -   Number of holes in x-direction
        num_y   -   Number of holes in y-direction
 */
module batteryGrid(dia, num_x, num_y) {
    move = dia+spaceBetween;
    
    for(i = [0:num_x-1]) {
        for(j = [0:num_y-1]) {
            translate([dia/2+i*move,dia/2+j*move,bottomThickness]) {
                cylinder(r=dia/2,h=trayHeight-bottomThickness,center=false);   
            }
        }
    }   
}

/* 
    Create a tray with rounded corners and a grid of holes

    Args:
        dia     -   Diameter of the holes
        num_x   -   Number of holes in x-direction
        num_y   -   Number of holes in y-direction
*/
module batteryTray(dia, num_x, num_y) {
    difference() {
        translate([calcSize(dia,num_x)/2, calcSize(dia,num_y)/2,trayHeight/2]) {
            roundCornersCube(calcSize(dia,num_x), calcSize(dia,num_y), trayHeight, 5);
        }
        translate([spaceBetween, spaceBetween, 0]) {
            batteryGrid(dia, num_x, num_y);
        }
    }
}


if(create=="AA") {
    batteryTray(diaAA, numAA_x, numAA_y);
} else if(create=="AAA") {
    batteryTray(diaAAA, numAAA_x, numAAA_y);
}