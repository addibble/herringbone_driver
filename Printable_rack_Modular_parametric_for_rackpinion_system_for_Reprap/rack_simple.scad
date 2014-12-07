// Parametric Modular Rack Mark "Ckaos" Moissette
//Based on the work of MattMoses and Fdavies :
//http://forums.reprap.org/read.php?1,51452,52099#msg-52099
//and Forrest Higgs:
// http://technocraticanarchist.blogspot.com/2010/01/high-speed-alternative-to-belts.html
//It is licensed under the Creative Commons - GNU GPL license.
// © 2011 by Mark "Ckaos" Moissette
//more info at :www.kaosat.net and
//http://www.thingiverse.com/thing:6011


pi=3.1415926535897932384626433832795;
innerRadius=3.1;//shaft radius, in mm
borders=2.5;//how thick should the borders around the central "shaft" be, in mm
diametralPitch=12;
numberOfTeeth=23;
pressureAngle=20*pi/180;




//example usage
rack3(innerRadius,borders,diametralPitch,numberOfTeeth,pressureAngle);

module rack3(innerRadius,borders,P,N,PA)
{
	// P = diametral pitch
	// N = number of teeth
	// PA = pressure angle in radians
	// x, y = linear offset distances
	a = 1/P; // addendum (also known as "module")
	d = 1.25/P; // dedendum (this is set by a standard)
	multiplier=20;
	height=(d+a)*multiplier;
	
	
	// find the tangent of pressure angle once
	tanPA = tan(PA*(180/pi));
	// length of bottom and top horizontal segments of tooth profile
	botL = (pi/P/2 - 2*d*tanPA)*multiplier;
	topL =( pi/P/2 - 2*a*tanPA)*multiplier;

	echo("botL",botL);
	echo("topL",topL);
	slantLng=tanPA*height;
	realBase=2*slantLng+topL;
	
	
	offset=topL+botL+2*slantLng;
	length=(realBase+botL)*N;

	echo("realBase",realBase);
	echo("height",height);
	echo("length",length);
	supportSize=(innerRadius+borders)*2;

	rotate([90,0,0])
	{
	translate([0,supportSize/2,0])
	{
	union()
	{
		difference()
		{
			cube(size=[length,supportSize,supportSize],center=true);
			rotate([0,90,0]) 
			{cylinder(h=length+10,r=innerRadius,center=true,$fn=100);}
		}

		for (i = [0:N-1]) 
		{
			translate([i*offset-length/2+realBase/2,0,supportSize/2]) 
			{	
				trapezoid([topL,supportSize],[realBase,supportSize],height);
			}
		}
	}
	}
	}
}



module trapezoid(top,base,height)//top : width*length, same for base
{
	//echo ("test",base[0]);
	basePT1=[
	-base[0]/2,
	base[1]/2,
	0];

	basePT2=[
	base[0]/2,
	base[1]/2,
	0];

	basePT3=[
	base[0]/2,
	-base[1]/2,
	0];

	basePT4=[
	-base[0]/2,
	-base[1]/2,
	0];
	//////////////////////////
	topPT1=[
	-top[0]/2,
	top[1]/2,
	height];

	topPT2=[
	top[0]/2,
	top[1]/2,
	height];

	topPT3=[
	top[0]/2,
	-top[1]/2,
	height];

	topPT4=[
	-top[0]/2,
	-top[1]/2,
	height];
	//////////////////////////

	polyhedron(
	points=[
		basePT1,
		basePT2,
		basePT3,
		basePT4,
		topPT1,
		topPT2,
		topPT3,
		topPT4],
	triangles=[
	//base
	[0,1,2],
	[0,2,3],
	//sides
	[3,7,0],
	[7,4,0],
	//
	[1,6,2],
	[1,5,6],
	//
	[2,6,3],
	[3,6,7],
	//
	[5,1,0],
	[4,5,0],
	//top
	[7,5,4],
	[5,7,6],
	]
	);

}





