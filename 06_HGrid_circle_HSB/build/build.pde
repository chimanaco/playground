// controlP5
int fader = 12; 
int poolNumber = 121; 
int colNumber = 11;
int startX = 25;
int startY = 25;
int spaceX = 55;
int spaceY = 55;
float scaleXSpeed = 0.002;
float scaleYSpeed = 0.003;
float angleSpeed = 0.005;
float scaleXMax = 4.50;
float scaleYMax = 3.00;
float hueSpeed = 0.12;
int saturationValue = 72;
int brightnessValue = 85;
int colorAlphaValue = 75;

String[][] cpArray = {
	{"fader","0","100", str(fader)},
	{"poolNumber","1","121", str(poolNumber)},
	{"colNumber","1","25", str(colNumber)},
	{"startX","0","100", str(startX)},
	{"startY","0","100", str(startY)},
	{"spaceX","0","100", str(spaceX)},
	{"spaceY","0","100", str(spaceY)},
	{"scaleXSpeed","0","0.01", str(scaleXSpeed)},
	{"scaleYSpeed","0","0.01", str(scaleYSpeed)},
	{"angleSpeed","0","0.01", str(angleSpeed)},
	{"scaleXMax","0","10", str(scaleXMax)},
	{"scaleYMax","0","10", str(scaleYMax)},
	{"hueSpeed","0","3", str(hueSpeed)},
	{"saturationValue","0","100", str(saturationValue)},
	{"brightnessValue","0","100", str(brightnessValue)},
	{"colorAlphaValue","0","100", str(colorAlphaValue)}
};

// Seed
float scaleXNoiseSeed = 0;
float scaleYNoiseSeed = 0;
float angleNoiseSeed = 0;

// Color
float hueShifter = 0;

// Hype
HCanvas c1;
HDrawablePool pool;

// Setup
void setup(){
	size(600,600);
	colorMode(HSB, 360, 100, 100);
	smooth();
	frameRate(30);

	// Hype init
	H.init(this).background(#202020);

	// setup cp5 (Should be after Hype init)
	setupCP5(cpArray);

	// Hype canvas
	hypeCanvas();

	// Hype draw
	hypeDraw();

	// saveHiRes(2);
	// noLoop();
}

// draw
void draw() {
	H.drawStage();
	hypeDraw();

	for (HDrawable d : pool) {
		hueShifter += hueSpeed;
		if (hueShifter > 360) hueShifter = 0;
		color c = color(hueShifter, saturationValue, brightnessValue, colorAlphaValue);
		d.fill( c );
		d.rotate(angleNoiseSeed * 360);
	}

	scaleXNoiseSeed += scaleXSpeed;
	scaleYNoiseSeed += scaleYSpeed;
	angleNoiseSeed += angleSpeed;

	saveFrame("../frames/#########.tif"); if (frameCount == 900) exit();
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

// Hype draw
void hypeDraw() {
	if(pool != null && c1.numChildren() > 0) {
		for (HDrawable d : pool) {
			c1.remove(d);
		}
		pool.destroy();
	}
	
	pool = new HDrawablePool(poolNumber);
	pool.autoParent(c1)
		.add(new HShape("circle.svg"))	
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
						.noStroke()
						.anchorAt(H.CENTER)
						.scale(
							scaleXMax * sin(scaleXNoiseSeed * pool.currentIndex()),
							scaleYMax * sin(scaleYNoiseSeed * pool.currentIndex())
						)
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
	hypeDraw();
}