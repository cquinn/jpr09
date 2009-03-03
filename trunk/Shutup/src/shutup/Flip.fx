package shutup;

import javafx.animation.Interpolator;
import javafx.stage.Stage;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.effect.PerspectiveTransform;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.transform.Scale;
import javafx.scene.transform.Translate;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;

/**
 * @author fredriv
 */

var topoffset = 0;
var topscale = 1.0 on replace { 
	topoffset = 100.0 * (1.0 - topscale);
	urx = 200 + 50 * (1.0 - topscale);
	ulx = -50 * (1.0 - topscale);
};
var bottomscale = 0.0;

var ulx = 0;
var urx = 200;

var topback = Group {
	content: Text {
	    font: Font {
    	    size: 300
    	},
    	stroke: Color.BLACK
    	fill: Color.BLACK
    	x: 10,
    	y: 200
    	content: "5"
	}
	clip: Rectangle {
    	x: 0,
		y: 0,
    	width: 200,
		height: 95,
	}
}

var top = Group {
	content: [ 
	Rectangle {
		x: 0
		y: 0
		width: 200
		height: 200
		fill: Color.WHITE
	},
	Text {
	    font: Font {
    	    size: 300
    	},
    	stroke: Color.BLACK
    	fill: Color.BLACK
    	x: 10,
    	y: 200
    	content: "4"
	}
	]
	clip: Rectangle {
    	x: 0,
		y: 0,
    	width: 200,
		height: 95,
	}
	transforms: [
		Translate {
			y: bind topoffset 
		}
		Scale {
			x: 1
			y: bind topscale
		}
	]
	effect: PerspectiveTransform {
		ulx: bind ulx	uly: -30
		urx: bind urx 	ury: -30
		lrx: 200	lry: 200
		llx: 0	lly: 200
	}
}

var bottom = Group {
	translateY: 100
//	translateX: 50
	content: [ 
	Rectangle {
		width: 200
		height: 400
		fill: Color.WHITE
	},
	Text {
	    font: Font {
    	    size: 300
    	},
//    	fill: Color.BLACK,
  //  	stroke: Color.BLACK,
    	x: 10,
    	y: 100
    	content: "5"
	}
	]
	clip: Rectangle {
    	x: 0,
		y: 5,
    	width: 200,
		height: 95,
	}
	transforms: [
		Scale {
			x: 1
			y: bind bottomscale
		}
	]
}

var bottomback = Group {
	translateY: 100
//	translateX: 50
	content: Text {
	    font: Font {
    	    size: 300
    	},
//    	fill: Color.BLACK,
  //  	stroke: Color.BLACK,
    	x: 10,
    	y: 100
    	content: "4"
	}
	clip: Rectangle {
    	x: 0,
		y: 5,
    	width: 200,
		height: 95,
	}
}

Stage {
    title : "MyApp"
    scene: Scene {
        width: 200
        height: 200
        content: [
        	topback,
        	bottomback, 
        	top,
        	bottom
        ]
    }
}

var t = Timeline {
    repeatCount: Timeline.INDEFINITE,
    keyFrames: [
        KeyFrame {
            time: 1s,
            values: [
            	topscale => 1.0,
            	bottomscale => 0.0
            ]
        }
        KeyFrame {
            time: 2s,
            values: [
            	topscale => 0.0 tween Interpolator.EASEOUT,
            	bottomscale => 0.0
            ]
        }
        KeyFrame {
            time: 3s,
            values: [
            	topscale => 0.0,
            	bottomscale => 1.0 tween Interpolator.EASEIN
            ]
        }
        KeyFrame {
            time: 4s,
            values: [
            	topscale => 0.0,
            	bottomscale => 1.0
            ]
        }
    ]
}

t.play();