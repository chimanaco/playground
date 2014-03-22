// controlP5
int fader = 50; 
int poolNumber = 2000; 
int rectRounding = 0; 
int rectSize = 10; 

String[][] cpArray = {
	{"fader","0","100", str(fader)},
	{"poolNumber","1","20000", str(poolNumber)},
	{"rectSize","0","50", str(rectSize)},
	{"rectRounding","0","50", str(rectRounding)}
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
		// .add(new HShape("line.svg"))
		.add(new HRect(rectSize).rounding(rectRounding))

		.layout(
			new HShapeLayout()
			.target(
				new HImage("shapeMapP5Van.png")
			)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noFill()
						.stroke(0, (int)random(255))
						// .noStroke()
						// .fill(0, (int)random(255))
						.anchorAt(H.CENTER)
						.size( (int)random(4,rectSize) )
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
