/*
OpenSCAD Script for creating grids that can be used 
as LED separators on LED matrices.

Author:     github.com/MaxAtoms
License:    GNU General Public License v3.0    
*/

/****** Parameters ******/
height = 5.5;           // height of the grid in z-direction
pixel_size = 6;         // length and height of one pixel
wall_thickness = .8;    // distance between each pixel
pixels_x = 32;          // number of pixels in x-direction
pixels_y = 32;          // number of pixels in y-direction

/*****************************************/
length_x = pixels_x * pixel_size;
length_y = pixels_y * pixel_size;

inner_x = (length_x - ((pixels_x+1) * wall_thickness)) / pixels_x;
inner_y = (length_y - ((pixels_y+1) * wall_thickness)) / pixels_y;

module cutout() {
    for(x =[1:pixels_x]) {
        for(y =[1:pixels_y]) {
            translate([x*wall_thickness+(x-1)*inner_x,y*wall_thickness+(y-1)*inner_y,0]) {
                cube([inner_x,inner_y,height]);
            } 
        }
    }
}

module grid() {
    difference() {
        cube([length_x, length_y, height]);
        cutout();
    }
}

grid();