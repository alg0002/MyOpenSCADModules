// z=0平面の上にcubeを作る
module cube2(
    x/*x方向の大きさ*/,
    y/*y方向の大きさ*/,
    z/*z方向の大きさ*/) {
    translate([0, 0, z/2])
        cube(size=[x,y,z], center=true);
}

// z=0平面の上に円柱を作る
module cylinder2(
    h2/*高さ*/, 
    r2/*円の半径*/) {
    translate([0, 0, h2/2])
        cylinder(h=h2, r=r2, center=true);
}

// z=0平面の上に角丸cubeを作る
module cubeR(
    x/*x方向の大きさ*/,
    y/*y方向の大きさ*/,
    z/*z方向の大きさ*/,
    r/*角丸の半径*/) {
    h = 0.000000000000001;
    translate([0, 0, z/2-h/2]) minkowski() {
        cube([x-r*2, y-r*2, z-h/2], center=true);
        cylinder(r=r, h=h);
    }
}

// 天面と底面がR面取りされた角丸cubeをz=0平面の上に作る
// ※要cubeR
// ※cube等よりほんの少し（0.01くらい？）小さくなることに注意・原因不明
module cubeRRcham(
    x/*x方向の大きさ*/,
    y/*y方向の大きさ*/,
    z/*z方向の大きさ*/,
    r/*角丸の半径*/,
    cr/*面取りの半径*/) {
    // ほんの少し高さが足りないようなので補正用：これでも補正は足りない
    // 0.0096350000000003くらい？？
    mod = 0.00963;
    translate([-x/2+cr, 0, cr*3-mod/2]) minkowski() {
        translate([0,0,-z/2]) cubeR(x-cr*2, y-cr*2, z-cr*2+mod, r-cr);
        translate([x/2-cr, 0, z/2-cr*2]) sphere(r=cr);
    }
}

// 天面がR面取りされた角丸cubeをz=0平面の上に作る
// ※要cubeR
// ※cube等よりほんの少し（0.01くらい？）小さくなることに注意・原因不明
module cubeRRcham2(
    x/*x方向の大きさ*/,
    y/*y方向の大きさ*/,
    z/*z方向の大きさ*/,
    r/*角丸の半径*/,
    cr/*面取りの半径*/) {
    // ほんの少し高さが足りないようなので補正用：これでも補正は足りない
    // 0.0096350000000003くらい？？
    mod = 0.00963;
    difference() {
        translate([-x/2+cr, 0, cr*3-mod/2-cr]) {
            minkowski() {
                translate([0,0,-z/2]) cubeR(x-cr*2, y-cr*2, z-cr*2+mod+cr, r-cr);
                translate([x/2-cr, 0, z/2-cr*2]) sphere(r=cr);
            }
        }
        translate([0,0,-cr*2]) cube2(x, y, cr*2);
    }
}

// 天面と底面がC面取りされた角丸cubeをz=0平面の上に作る
// ※要cubeR
// ※cube等よりz方向にほんの少し（0.01くらい？）小さくなることに注意・原因不明
module cubeRCcham(
    x/*x方向の大きさ*/,
    y/*y方向の大きさ*/,
    z/*z方向の大きさ*/,
    r/*角丸の半径*/,
    c/*面取りの直角二等辺三角形の2辺の長さ*/) {
    translate([0, 0, z/2]) hull() {
        translate([0, 0,  z/2-c]) cubeR(x-c*2, y-c*2, c, r);
        translate([0, 0, -(z-c*2)/2]) cubeR(x, y, z-c*2, r);
        translate([0, 0, -z/2]) cubeR(x-c*2, y-c*2, c, r);
    }
}

// 天面がC面取りされたcubeをz=0平面の上に作る
module cubeCcham(
    x/*x方向の大きさ*/,
    y/*y方向の大きさ*/,
    z/*z方向の大きさ*/,
    c/*面取りの直角二等辺三角形の2辺の長さ*/) {
    h = 0.000000000000001;
    translate([0, 0, (z-c)/2]) hull() {
        translate([0, 0, (z+c)/2-h/2]) cube(size=[x-c*2, y-c*2, h], center=true);
        cube(size=[x, y, z-c], center=true);
    }
}

// 天面と底面がC面取りされたcubeをz=0平面の上に作る
module cubeCcham2(
    x/*x方向の大きさ*/,
    y/*y方向の大きさ*/,
    z/*z方向の大きさ*/,
    c/*面取りの直角二等辺三角形の2辺の長さ*/) {
    h = 0.000000000000001;
    translate([0, 0, z/2]) hull() {
        translate([0, 0, (z+c*2)/2-h/2-c]) cube(size=[x-c*2, y-c*2, h], center=true);
        cube(size=[x, y, z-c*2], center=true);
        translate([0, 0, -z/2+h/2]) cube(size=[x-c*2, y-c*2, h], center=true);
    }
}

// 天面と底面と側面がC面取りされたcubeをz=0平面の上に作る
module cubeCcham3(
    x/*x方向の大きさ*/,
    y/*y方向の大きさ*/,
    z/*z方向の大きさ*/,
    c/*面取りの直角二等辺三角形の2辺の長さ*/) {
    h = 0.000000000000001;
    translate([0, 0, z/2]) {
        difference() {
            hull() {
                translate([0, 0, (z+c*2)/2-h/2-c]) cube(size=[x-c*2, y-c*2, h], center=true);
                cube(size=[x, y, z-c*2], center=true);
                translate([0, 0, -z/2+h/2]) cube(size=[x-c*2, y-c*2, h], center=true);
            }
            translate([ x/2,  y/2, 0]) rotate([0,0,45]) cube(size=[c*sqrt(2), c*sqrt(2), z], center=true);
            translate([-x/2,  y/2, 0]) rotate([0,0,45]) cube(size=[c*sqrt(2), c*sqrt(2), z], center=true);
            translate([ x/2, -y/2, 0]) rotate([0,0,45]) cube(size=[c*sqrt(2), c*sqrt(2), z], center=true);
            translate([-x/2, -y/2, 0]) rotate([0,0,45]) cube(size=[c*sqrt(2), c*sqrt(2), z], center=true);
        }
    }
}