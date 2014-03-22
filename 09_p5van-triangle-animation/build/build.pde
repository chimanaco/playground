// controlP5
int fader = 90; 
int poolNumber = 5000; 
int pathEdge = 5; 
int pathDepth = 5; 
int pathSize = 10; 

String[][] cpArray = {
	{"fader","0","100", str(fader)},
	{"poolNumber","1","20000", str(poolNumber)},
	{"pathEdge","0","10", str(pathEdge)},
	{"pathDepth","0","10", str(pathDepth)},
	{"pathSize","1","100", str(pathSize)}
};

HCanvas c1;
HDrawablePool pool;
float angle = 0;
float speed = 0.1;

void setup(){
	size(940, 200);
	H.init(this).background(#FFFFFF);
	smooth();
	frameRate(30);

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

	saveFrame("../frames/#########.tif"); if (frameCount == 200) exit();
}

// hype using draw
void hypeDraw() {
	if(pool != null && c1.numChildren() > 0) {
		for (HDrawable d : pool) {
			c1.remove(d);
		}
		pool.destroy();
	}
	
	angle += speed;
	float pos = (sin(angle) + 1) / 2;
	int num = ceil(poolNumber * pos);

	pool = new HDrawablePool(num);
	pool.autoParent(c1)
		.add(new HPath())
		.layout(
			new HShapeLayout()
			.target(
				new HImage("shapeMapP5Van.png")
			)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HPath path = (HPath) obj;
					path
						// .star( pathEdge, pathDepth )
						.triangle( H.ISOCELES, H.RIGHT )
						.size(pathSize)
						// .noStroke()
						// .fill(0, (int)random(255))
						.noFill()
						.stroke(0, (int)random(255))
						.anchorAt(H.CENTER)
						.rotation( (int)random(360) )
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
