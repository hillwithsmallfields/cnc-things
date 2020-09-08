include <psu-dimensions.scad>
include <psu-case-parts.scad>
include <psu-components.scad>

module components_on_base() {
     base();
     internal_components();
}

components_on_base();

