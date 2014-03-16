// http://kiris-artworks.com/THE-SQUARE-PATTERN-EXPERIMENT

HDrawablePool pool;
HColorPool colors;

void setup(){
	size(600,600);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#000000,#010101,#0267B4,#AD3B92,#E5512E,#21A067,#EF8B2D);
	pool = new HDrawablePool(121);
	pool.autoAddToStage()
		.add(new HShape("square.svg"))

		.layout(
			new HGridLayout()
			.startX(25)
			.startY(25)
			.spacing(55,55)
			.cols(11)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noStroke()
						.anchorAt(H.CENTER)
						.rotate( (int)random(4) * 90 )
					;
					d.randomColors(colors.fillOnly());
				}
			}
		)
		.requestAll()
	;

	saveHiRes(1);
	noLoop();
}

void draw() {
	H.drawStage();
}