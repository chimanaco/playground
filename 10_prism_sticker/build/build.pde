int len;
int r = 40;
float b = 1.5;
float rAngle = 0;
float rSpeed = 0.0001;
// float gAngle = 0;
// float gSpeed = 0.0001;
// float bAngle = 0;
// float bSpeed = 0.0001;

float r1 = 0; 
int g1 = 255; 
int b1 = 255;
int r2 = 255; 
int g2 = 0; 
int b2 = 255;
int r3 = 0; 
int g3 = 255; 
int b3 = 0;

String[][] cpArray = {
    {"r","1","100", str(r)},
    {"b","0","2", str(b)},
    {"r1","0","255", str(r1)},
    {"g1","0","255", str(g1)},
    {"b1","0","255", str(b1)},
    {"r2","0","255", str(r2)},
    {"g2","0","255", str(g2)},
    {"b2","0","255", str(b2)},
    {"r3","0","255", str(r3)},
    {"g3","0","255", str(g3)},
    {"b3","0","255", str(b3)}
};

void setup() {
    size(600, 600, P2D);
    frameRate(30);
    H.init(this).background(255); 
    // setup cp5 (Should be after Hype init)
    setupCP5(cpArray);
    noStroke();
}

void draw() {
    H.drawStage();

    len = (int) width / r;

    for (int j = 0; j < len; ++j) {
        for (int i = 0; i < len; ++i) {
            r1 = map( sin(b * (i * rAngle) + j), -1, 1, 0, 255);
            pushMatrix();
            translate(i * r , j * r);
                beginShape();
                fill(r1, g1, b1);
                vertex(0, 0);
                fill(r2, g2, b2);
                vertex(0, r);
                fill(r3, g3, b3);
                vertex(r, r);
                endShape();

                beginShape();
                fill(r1, g1, b1);
                vertex(0, 0);
                fill(r2, g2, b2);
                vertex(r, 0);
                fill(r3, g3, b3);
                vertex(r, r);
                endShape();
            popMatrix();

            rAngle += rSpeed;
            // gAngle += gSpeed;
            // bAngle += bSpeed;
        }
    }

    saveFrame("../frames/#########.tif"); if (frameCount == 900) exit();

}