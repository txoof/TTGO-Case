module button(dim=[3.5, 4.5, 1.9], knob_z=2.5, knob_d=2.2, $fn=36) {
    color("silver") {
        cube(dim, center=true);
    }
    color("cornsilk") {
        translate([0, 0, -dim[2]/2])
        cylinder(h=knob_z, d=knob_d);
    }
}

function dupont_pin_length(n=2, pitch=2.54, spacer_w=2.5) = (n - 1) * pitch + spacer_w;

module dupont_pin(n=2, pitch=2.54, size=.64, pin_h=11, spacer_h=2.5, spacer_w=2.5) {
    span = (n - 1) * pitch;
    spacer_l = dupont_pin_length(n, pitch, spacer_w);

    color("slategrey") {
        translate([0, 0, spacer_h / 2])
        cube([spacer_l, spacer_w, spacer_h], center=true);
    }

    color("gold") {
        for (i = [0 : n - 1]) {
            translate([i * pitch - span / 2, 0, pin_h / 2 -3])
            cube([size, size, pin_h], center=true);
        }
    }
}

module chip(dim) {
    color("darkgoldenrod") {
        cube(dim, center = true);
    }
}