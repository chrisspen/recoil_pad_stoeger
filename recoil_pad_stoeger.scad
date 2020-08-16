use <MCAD/regular_shapes.scad>

module recoil_pad_outline(thickness=3){    
    s1=.8;
    //translate([0,0,-5])
    rotate([0,0,180-.6])
    scale([s1,s1,1])
    linear_extrude(height=thickness)
    import("recoil_pad_outline.svg");
}

module recoil_pad_screws(d=6, length=100){
    for(i=[-1:2:1])
    translate([0,(90.3/2+6/2)*i-10.85+7.3+6/2,0]){
        color("red")
        cylinder(d=d, h=length, center=true, $fn=50);
    }
}

module recoil_pad_base(){
    difference(){
            
        union(){
            // small egg
            scale([3.25,7.85,1])
            translate([0,-15/2,0])
            linear_extrude(height=9)
            egg_outline(10, 15, $fn=100);

            // big egg
//            translate([0,0,-3])
//            scale([4,8.4,1])
//            translate([0,-15/2,0])
//            linear_extrude(height=3)
//            egg_outline(10, 15, $fn=100);            
            translate([0,0,-3])
            recoil_pad_outline(thickness=3);
        }
        
        // mass cutout
        if(1)
        color("red")
        translate([0,0,3.5])
        scale([.9,1.2,1])
        scale([3.25,7.85,1])
        translate([0,-15/2,0])
        linear_extrude(height=9)
        egg_outline(10, 15, $fn=100);
        
        recoil_pad_screws();

    }//end diff
}

module recoil_pad_cushion2(){
    s1 = 0.9;
    r = 2;
    //minkowski(){
        //scale([s1,s1,1])
        //recoil_pad_outline(thickness=17);
        //translate([41/2-r,0,17])
        //sphere(r=r, $fn=50);
    //}
    difference(){
        union(){
            intersection(){
                recoil_pad_outline(thickness=17/2);
                
                if(0)
                color("green")
                scale([2.1,1,1])
                translate([0,0,0])
                rotate([90,0,0])
                cylinder(d=20, h=200, center=true, $fn=50);
                
                if(1)
                color("green")
                scale([1.75,8,1])
                translate([0,0,-5])
                sphere(d=30, $fn=50);
                
            }
            
            translate([0,0,-17/2])
            recoil_pad_outline(thickness=17/2);
        }

        // mount holes
        if(1){
            translate([0,0,17-14])
            recoil_pad_screws(d=9.5, length=17);
            
            recoil_pad_screws();
        }
        
        diamond_grid(total_width=120);
    }//end diff
    
}

module recoil_pad_cushion3(thickness=34, width=14){
    /*
    infill=5%
    shell=0.8
    */
    s1 = 0.9;
    r = 2;
    
    difference(){
        translate([0,0,-thickness/2])
        recoil_pad_outline(thickness=thickness);

        // mount holes
        //translate([-100,0,0])
        if(1){
            if(1)
            translate([0,0,18.5])
            recoil_pad_screws(d=9.5, length=thickness*2);
            
            recoil_pad_screws(d=6, length=thickness*2);
        }
        
        diamond_grid(total_width=120, width=width, height=9, layers=6, grid_height=31);
//        diamond_grid(total_width=120, width=15, height=9, layers=6, grid_height=31);
//        diamond_grid(total_width=120, width=13, height=8, layers=6, grid_height=31);
    }//end diff
    
}

module diamond_pillar(length=100, width=12, height=8){
    
    color("red")
    rotate([0,90,0])
    rotate([0,0,90])
    translate([-width/2,0,-length/2])
    linear_extrude(height=length)
    polygon([[0,0],[width/2,height/2],[width,0],[width/2,-height/2]]);

}

module diamond_grid(width=13, height=8, total_width=84, layers=3, grid_height=12){
    
    intersection(){
        color("blue")
        cube([50,total_width,grid_height], center=true);
        
        union(){
            
            for(j=[-floor(layers/2):1:floor(layers/2)])
            for(i=[-10:10])
            translate([0,(12+5)*i+8.5*j,j*6])
            diamond_pillar(width=width, height=height);
        }
    }
}

if(0)
color("green")
recoil_pad_base();

if(0)
translate([0,0,-10])
recoil_pad_outline();

if(0)
recoil_pad_cushion();

if(1)
recoil_pad_cushion3();

// thickness gauge
if(0)
translate([0,60,0])
color("red")
cube([1,1,3.5]);

/*
length=118
width=32.79
width to inner hole diameter=90.3
hole diameter=6
fat end hole diameter distance=7.3
thin end hole diameter distance=9.5

@20mm -> 25.3mm
@40mm -> 31.43mm
@60mm -> 32.54
@80mm -> 30.43
@100mm -> 25.09
*/

// inner limits
if(0)
color("blue"){
    cube([1,118,1], center=true);//max length
    cube([32.5,50,1], center=true);//max width
    
    translate([0,-(118/2-20),0])
    cube([27,1,1], center=true);//20mm
    
    translate([0,-(118/2-40),0])
    cube([31.43,1,1], center=true);//40mm
    
    translate([0,-(118/2-60),0])
    cube([32.79,1,1], center=true);//60mm
    
    translate([0,-(118/2-80),0])
    cube([30.43,1,1], center=true);//80mm
    
    translate([0,-(118/2-100),0])
    cube([24,1,1], center=true);//100mm
}

// outside limits
if(0)
translate([0,0,-30])
color("purple"){
    cube([1,127,1], center=true);//max length
    cube([41,50,1], center=true);//max width

}

if(0)
for(i=[-1:2:1])
translate([0,(90.3/2+6/2)*i-10.85+7.3+6/2,0]){
    color("red")
    cylinder(d=6, h=100, center=true, $fn=50);
    
    color("orange")
    if(i==-1)
    cylinder(d=20, h=5, center=true, $fn=50);
    
    color("purple")
    if(i==1)
    translate([0,5,10])
    cylinder(d=12, h=5, center=true, $fn=50);
}
