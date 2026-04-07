$fn = 36;
inner_clearance = 1;

outer_x = 57.3;
outer_y = 91.55;
inner_x = 50;
inner_y = 84;

screw_post_d = 8.3;
screw_post_loc_x = inner_x/2 - screw_post_d/2 - 2.7;
screw_post_loc_y = inner_y/2 - screw_post_d/2 -2.75;

in_screw_post_d = 5.55;
in_screw_post_loc_x = screw_post_loc_x;
in_screw_post_loc_y = screw_post_loc_y - (screw_post_d - in_screw_post_d)/2 - in_screw_post_d - 16;

mounting_screw_d = 2.5;

module inner_template() {
    color("lightsteelblue")
    difference() {
        square([inner_x, inner_y], center=true);
        for (i = [-1, 1]) {
            for (j = [-1, 1]) {
                translate([i*screw_post_loc_x, j*screw_post_loc_y]) {
                    circle(d=screw_post_d);
                }
            }
        }

        for (i = [-1, 1]) {
            for(j = [-1, 1]) {
                translate([i* in_screw_post_loc_x, j* in_screw_post_loc_y]) {
                        circle(d=in_screw_post_d);
                }
            }
        }

    }
}

module pcb_template(){
    corner_cut_size = [
                       inner_x/2 - screw_post_loc_x + screw_post_d/2 + inner_clearance,
                       inner_y/2 - screw_post_loc_y + screw_post_d/2 + inner_clearance
                      ];

    corner_cut_loc_x = inner_x/2 - corner_cut_size[0]/2;
    corner_cut_loc_y = inner_y/2 - corner_cut_size[1]/2;
    

    difference() {
        square([inner_x, inner_y], center=true);
        for (i = [-1, 1]) {
            for (j = [-1, 1]) {
                translate([i*corner_cut_loc_x, j*corner_cut_loc_y]) {
                    square(corner_cut_size, center=true);
                }
                translate([i*in_screw_post_loc_x, j*in_screw_post_loc_y]) {
                    circle(d=mounting_screw_d);
                }
            }
        }
    }
    
}

inner_template();
// pcb_template();
// t_x = screw_post_loc_x;
// t_y = screw_post_loc_y - 16/2 - screw_post_d/2;
// translate([t_x, t_y]){
//     #cube([5, 16, 2], center=true);
// }