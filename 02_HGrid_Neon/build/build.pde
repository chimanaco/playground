HDrawablePool pool1;
HColorField colors;
int strokeAlpha = 0;
int outerWidth = 30;
int innerWidth = 15;

void setup(){
	size(600,600);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorField(width,height)
		.addPoint(0, height/2, #0267B4, 0.5) // blue
		.addPoint(width, height/2, #AD3B92, 0.5) // purple

		.addPoint(width/2, 0, #E5512E, 0.3) // orange
		.addPoint(width/2, height, #21A067, 0.3) // green		
		.strokeOnly()
	;

	
	// outer glow
	for (int i = 0; i < outerWidth; i++) {
		HDrawablePool pool = new HDrawablePool(49);
		strokeAlpha = (int) (255 - sin(i * HALF_PI / outerWidth) * 255);
		pool.autoAddToStage().add(new HEllipse(20 + i)).layout(new HGridLayout().startX(60).startY(60).spacing(80,80).cols(7))
			.onCreate(
				new HCallback() {
					public void run(Object obj) {
						HEllipse d = (HEllipse) obj;
						d
							.noFill()
							.strokeWeight(1)
							.stroke(#000000, strokeAlpha)
							.anchorAt(H.CENTER)
						;
						colors.applyColor(d);
					}
				}
			)
			.requestAll()
		;
	}

	// inner glow
	for (int j = 0; j < innerWidth; j++) {
		HDrawablePool pool = new HDrawablePool(49);
		strokeAlpha = (int) (255 - sin(j * HALF_PI / innerWidth) * 255);
		pool.autoAddToStage().add(new HEllipse(20 - j)).layout(new HGridLayout().startX(60).startY(60).spacing(80,80).cols(7))
			.onCreate(
				new HCallback() {
					public void run(Object obj) {
						HEllipse d = (HEllipse) obj;
						d
							.noFill()
							.strokeWeight(1)
							.stroke(#000000, strokeAlpha)
							.anchorAt(H.CENTER)
						;
						colors.applyColor(d);
					}
				}
			)
			.requestAll()
		;
	}

	// white ring
	pool1 = new HDrawablePool(49);
	pool1.autoAddToStage().add(new HEllipse(20)).layout(new HGridLayout().startX(60).startY(60).spacing(80,80).cols(7))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HEllipse d = (HEllipse) obj;
						d
							.noFill()
							.strokeWeight(2)
							.stroke(#FFFFFF)
							.anchorAt(H.CENTER)
						;
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
