// controlP5
int fader = 90; 
int poolNumber = 121; 
int colNumber = 11;
int startX = 25;
int startY = 25;
int spaceX = 55;
int spaceY = 55;

String[][] cpArray = {
	{"fader","0","100", str(fader)},
	{"poolNumber","1","121", str(poolNumber)},
	{"colNumber","1","25", str(colNumber)},
	{"startX","0","100", str(startX)},
	{"startY","0","100", str(startY)},
	{"spaceX","0","100", str(spaceX)},
	{"spaceY","0","100", str(spaceY)}
};

// Hype
HCanvas c1;
HDrawablePool pool;
HColorPool colors;

// noise
float scaleNoiseSeed = 0;

float hueShifter = 0;

// setup
void setup(){
	size(600,600);
	smooth();
	colorMode(HSB, 360, 100, 100);
	// strokeWeight(0.1);
	frameRate(30);

	// H.init(this).background(#202020).autoClear(false);
	H.init(this).background(#202020);
	
	// setup cp5
	setupCP5(cpArray);

	// Hype canvas
	hypeCanvas();

	// init Hype
	hypeDraw();

	// saveHiRes(2);
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

// draw
void draw() {
	H.drawStage();

	hypeDraw();

	strokeWeight(0.5);
	for (HDrawable d : pool) {
		hueShifter += 0.01;
		if (hueShifter >360) hueShifter=0;
		color c = color(hueShifter, 75, 40);
		d.stroke( c );
	}

	// saveFrame("../frames/#########.tif"); if (frameCount == 900) exit();
}

// hype using draw
void hypeDraw() {
	if(pool != null && c1.numChildren() > 0) {
		for (HDrawable d : pool) {
			c1.remove(d);
		}
		pool.destroy();
	}
	
	colors = new HColorPool(#c6e1d9,#a9bb3c,#72a4b7,#37589b);

	pool = new HDrawablePool(poolNumber);
	pool.autoParent(c1)
		.add(new HShape("square.svg"))
		
		.layout(
			new HGridLayout()
			.startX(startX)
			.startY(startY)
			.spacing(spaceX, spaceY)
			.cols(colNumber)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noFill()
						.anchorAt(H.CENTER)
						.scale(1 * sin(scaleNoiseSeed * pool.currentIndex()))
					;
				}
			}
		)
		.requestAll()
	;
	scaleNoiseSeed += 0.01;
}

// function controlEvent will be invoked with every value change 
// in any registered controller
public void controlEvent(ControlEvent e) {
	if(e.getLabel() == "fader") {
		hypeCanvas();
	}
	hypeDraw();
}