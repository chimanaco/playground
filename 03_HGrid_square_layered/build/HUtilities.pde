/*

	INDEX
	-----------------------
	1. Setup controlp5 
	2. Save a sketch as png
	3. Save a sketch as PDF 
	4. Key press actions

*/

/* -----------------------------------------	
	1. Setup controlp5

	@param myArray required var, min value, max value, default value
	@return void
----------------------------------------- */

import controlP5.*;
ControlP5 cp5;

void setupCP5(String[][] myArray) {
	// position
	int xPos = 10;
	int yPos = 10;  
	int yMargin = 15;
	int len = myArray.length;

	// cp5 
	cp5 = new ControlP5(this);

	for (int i = 0; i < len; i++) {
		cp5.addSlider(myArray[i][0])
			.setPosition(xPos, yPos + yMargin * i )
		    .setRange(float(myArray[i][1]), float(myArray[i][2]))
		    .setValue(float(myArray[i][3]));
		;
	}
}

/* -----------------------------------------	
	2. Save a sketch as png
	
	@param scaleFactor required Ratio
	@return void

	// put these lines in draw()
	saveHiRes(2);
	noLoop();
----------------------------------------- */

void saveHiRes(int scaleFactor) {
	PGraphics hires = createGraphics(width*scaleFactor, height*scaleFactor, JAVA2D);

	beginRecord(hires);
	hires.scale(scaleFactor);

	if (hires == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(hires, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
	hires.save("render.png");
}

/* -----------------------------------------	
	3. Save a sketch as PDF
	
	@return void
	
	// put these lines in draw()
	saveVector();
	noLoop();
----------------------------------------- */

import processing.pdf.*;

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}

/* -----------------------------------------	
	4. Key press actions

	@return void

	// spacebar = pause and restart animation
	// +        = advance 1 interation in the animation
	// r        = render to PDF
	// c        = toggle cp5 display 
	
	// put these lines on the top.
	boolean paused = false;
	boolean record = false;

----------------------------------------- */

boolean paused = false;
boolean record = false;
boolean cp5Visble = true;

void keyPressed() {
	if (key == ' ') {
		if (paused) {
			loop();
			paused = false;
		} else {
			noLoop();
			paused = true;
		}
	}

	if (key == '+') {
		redraw();
	}

	if (key == 'r') {
		record = true;
		saveVector();
	}

	if (key == 'c') {
		if (cp5Visble) {
			cp5.hide();
		} 
		else {
			cp5.show();
		}
		cp5Visble = !cp5Visble;
	}

	// if (key == 'u') {
	// 	changeDrawableColor();
	// }
}