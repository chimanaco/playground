HDrawablePool poolBG, poolBase;
HColorPool colorsBG;
HColorField colorsBase, colorsSQ1, colorsSQ2;
int strokeAlpha = 0;
int outerWidth = 25;
int innerWidth = 15;

void setup(){
	size(600,600);
	H.init(this).background(#202020);
	smooth();

	// colorPool
	colorsBG = new HColorPool(#000000,#010101,#0267B4,#AD3B92,#E5512E,#21A067,#EF8B2D);

	// colorField
	colorsBase = new HColorField(width,height)
		.addPoint(width/2, height / 2, #0267B4, 0.5) // blue		
		.fillAndStroke()
	;

	// colorField
	colorsSQ1 = new HColorField(width,height)
		.addPoint(width/2, height / 2, #FFFFFF, 0.5) // purple		
		.fillAndStroke()
	;

	colorsSQ2 = new HColorField(width,height)
		.addPoint(0, height/2, #0267B4, 0.5) // blue
		.strokeOnly()
	;


	// background
	poolBG = new HDrawablePool(121);
	poolBG.autoAddToStage()
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
						.noFill()
						.anchorAt(H.CENTER)
						.rotate( (int)random(4) * 90 )
					;
					d.randomColors(colorsBG.strokeOnly());
				}
			}
		)
		.requestAll()
	;


	
	// purple gradation
	poolBase = new HDrawablePool(256);
	poolBase.autoAddToStage().add(new HRect(40)).layout(new HGridLayout().startX(20).startY(20).spacing(40,40).cols(16))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HRect d = (HRect) obj;
						d
							.noStroke()
							.fill(#000000, 200)
							.anchorAt(H.CENTER)
						;
						colorsBase.applyColor(d);
				}
			}
		)
		.requestAll()
	;

	// white rect
	drawPoolRect(40, 40);
	drawPoolRect(70, 70);

	saveHiRes(1);
	noLoop();
}

void draw() {
	H.drawStage();
}

void drawPoolRect(int sx, int sy) {
	HDrawablePool p = new HDrawablePool(64);
	p.autoAddToStage().add(new HRect(40)).layout(new HGridLayout().startX(sx).startY(sy).spacing(70,70).cols(8))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HRect d = (HRect) obj;
						d
							// .noStroke()
							.noFill()
							.strokeWeight(10)
							.stroke(#000000, (int) random(0,255))
							.anchorAt(H.CENTER)
						;
						colorsSQ1.applyColor(d);
				}
			}
		)
		.requestAll()
	;
}
