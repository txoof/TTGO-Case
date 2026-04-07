use <components.scad>
board_x = 25.09;
board_y = 51.49;
board_z = 1.3;
board_dim = [board_x, board_y, board_z];


usbc_x = 9;
usbc_y = 7.4;
usbc_z = 3.3;
port_loc_z = 1.7;
usbc_loc = [0, -(board_y/2 - usbc_y/2 + port_loc_z), board_z/2 + usbc_z/2];

screen_x = 17.7;
screen_y = 31.35;
screen_z = 3.1 - board_z;
// distance from top
screen_loc_y = 6.2;
screen_loc = [0, board_y/2 - screen_y/2 - screen_loc_y, board_z/2 + screen_z/2];

button_x = 3.5;
button_y = 4.5;
button_z = 1.9;
button_knob_z = 2.5;
button_knob_d = 2.2;


// button_loc_x = board_x/2 - 2.59;
// button_loc_y = board_y/2 - 1.35;
button_loc_x = board_x/2 - button_x/2 - 2.7;
button_loc_y = -board_y/2 + button_y/2 + 1.35;
button_loc_z = board_z/2 + button_z/2;
button_loc = [button_loc_x, button_loc_y, button_loc_z];

n_pins = 12;
pin_block_len = dupont_pin_length(n=n_pins);
pin_loc_x = board_x/2 - 2.5/2;
pin_loc_y = board_y/2 - pin_block_len/2 - 7.5;
pin_loc_z = -board_z/2;

pin_loc = [pin_loc_x, pin_loc_y, pin_loc_z];


reset_button_y = 4.75;
reset_button_x = 1.85;
reset_button_z = 2.55;
reset_knob_z = 3.5; 
reset_knob_d = 1;
reset_loc_x = board_x/2 - reset_button_z/2;
reset_loc_y = board_y/2 - reset_button_y/2 - 37.4;
reset_loc_z = board_z/2 + reset_button_x/2;
reset_loc = [reset_loc_x, reset_loc_y, reset_loc_z];

r_chip_z = 2.45 - board_z;
r_chip_x = 3;
r_chip_y = 2;
r_chip_loc_x = board_x/2 - r_chip_x/2 - 2; 
r_chip_loc_y = -board_y/2 + r_chip_y/2 + 3.3;
r_chip_loc_z = -board_z/2 - r_chip_z/2;
r_chip_loc = [r_chip_loc_x, r_chip_loc_y, r_chip_loc_z];

l_chip_z = 2;
l_chip_x = 4;
l_chip_y = 4;
l_chip_loc_x = -board_x/2 + l_chip_x/2 +1;
l_chip_loc_y = -board_y/2 + l_chip_y/2 + 3.4;
l_chip_loc_z = -board_z/2 - l_chip_z/2;
l_chip_loc = [l_chip_loc_x, l_chip_loc_y, l_chip_loc_z];

module board() {
    color("darkslategray") {
        difference() {
            cube(board_dim, center=true);
        }
    }
    //usb c port
    color("silver") {
        translate(usbc_loc)
        cube([usbc_x, usbc_y, usbc_z], center=true);
    }
    //screen
    color("cadetblue") {
        translate(screen_loc) {
            cube([screen_x, screen_y, screen_z], center=true);
        }
    }
    for (i = [-1, 1]) {
        translate([button_loc[0] * i, button_loc[1], button_loc[2]]) {
            button();
        }
        translate([pin_loc[0] * i, pin_loc[1], pin_loc[2]]) {
            rotate([0, 180, 90]) {
                dupont_pin(n_pins);
            }
        }
    }
    translate(reset_loc) {
        rotate([0, 90, 0]) {
            button([reset_button_x, reset_button_y, reset_button_z], knob_z=reset_knob_z, knob_d=reset_knob_d);
        }

    }
    translate(r_chip_loc) {
        chip([r_chip_x, r_chip_y, r_chip_z]);
    }

    translate(l_chip_loc) {
        chip([l_chip_x, l_chip_y, l_chip_z]);
    }
}

board();
