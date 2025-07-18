var x = argument0;
var y = argument1;

// Integer cell coords, wrapped to [0..255]
var xi = floor(x) & 255;
var yi = floor(y) & 255;

// Fractional parts
var fx = x - floor(x);
var fy = y - floor(y);

// Fade function
function fade(t) {
    return t * t * t * (t * (t * 6 - 15) + 10);
}

// Lerp
function lerp(a, b, t) {
    return a + t * (b - a);
}

// Gradient: four simple directions
function grad(hash, dx, dy) {
    switch (hash & 3) {
        case 0: return  dx + dy;
        case 1: return -dx + dy;
        case 2: return  dx - dy;
        default: return -dx - dy;
    }
}

// Wrap-perm helper
function perm(i) {
    // wrap into 0..511
    return global.perlin_perm[i & 511];
}

// Hash lookups
var aa = perm(perm(xi    ) + yi    );
var ab = perm(perm(xi    ) + yi + 1);
var ba = perm(perm(xi + 1) + yi    );
var bb = perm(perm(xi + 1) + yi + 1);

// Fade curves
var u = fade(fx);
var v = fade(fy);

// Corners blended
var x1 = lerp(
    grad(aa, fx    , fy    ),
    grad(ba, fx - 1, fy    ),
    u
);
var x2 = lerp(
    grad(ab, fx    , fy - 1),
    grad(bb, fx - 1, fy - 1),
    u
);

var result = lerp(x1, x2, v);

// Already in approximately [–1,1]
return result;