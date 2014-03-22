// controlP5
int fader = 50; 
int poolNumber = 20000; 

String[][] cpArray = {
	{"fader","0","100", str(fader)},
	{"poolNumber","1","20000", str(poolNumber)},
};

HCanvas c1;
HDrawablePool pool;

void setup(){
	size(600, 128);
	frameRate(30);
	H.init(this).background(#FFFFFF);
	smooth();

	// setup cp5
	setupCP5(cpArray);

	// Hype canvas
	hypeCanvas();

	// init Hype
	hypeDraw();

	// saveHiRes(1);
	// noLoop();
}
 
// Hype canvas
void hypeCanvas() {
	if(c1 != null) {
		H.remove(c1);
		c1 = null;
	}

	// c1 = new HCanvas();
	c1 = new HCanvas().autoClear(false).fade(fader);
	H.add(c1);
}

void draw() {
	H.drawStage();

	hypeDraw();

	saveFrame("../frames/#########.tif"); if (frameCount == 30) exit();
}

// hype using draw
void hypeDraw() {
	if(pool != null && c1.numChildren() > 0) {
		for (HDrawable d : pool) {
			c1.remove(d);
		}
		pool.destroy();
	}
	
	pool = new HDrawablePool(poolNumber);
	pool.autoParent(c1)
		.add(new HShape("line.svg"))
		// .add(new HShape("circle.svg"))

		.layout(
			new HShapeLayout()
			.target(
				new HImage("shapeMapP5Van.png")
			)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noFill()
						.stroke(0, (int)random(255))
						.anchorAt(H.CENTER)
						.size( (int)random(3,10) )
						.rotate( (int)random(360) )
					;
				}
			}
		)
		.requestAll()
	;
}

// function controlEvent will be invoked with every value change 
// in any registered controller
public void controlEvent(ControlEvent e) {
	if(e.getLabel() == "fader") {
		hypeCanvas();
	}
	// hypeDraw();
}
