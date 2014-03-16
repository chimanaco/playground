HShape d;
HPixelColorist colors;

void setup(){
	size(600,600);
	H.init(this).background(#202020);
	smooth();

	colors = new HPixelColorist("j.jpg");

	for (int i = 0; i<10000; i++){
		d = new HShape("circle.svg");
		d
			.enableStyle(false)
			.loc( (int)random(width), (int)random(height) )
			// .strokeWeight(3)
			// .stroke( colors.getColor( d.x(), d.y() ) )
			.noStroke()
			.fill( colors.getColor( d.x(), d.y() ), 100 )
			.size( (int)random(10,35) )
			.rotate( (int)random(360) )
			.anchorAt(H.CENTER)
		;
		H.add(d);
	}

	saveHiRes(1);
	noLoop();
}
 
void draw() {
	H.drawStage();
}