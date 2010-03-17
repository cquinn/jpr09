/*
* Main.fx
 *
 * Created on Mar 2, 2009, 12:48:20 PM
 */

package shutup;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.paint.Color;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import javafx.scene.shape.Rectangle;
import javafx.scene.Group;
import javafx.scene.effect.DropShadow;
import javafx.scene.input.MouseEvent;
import javafx.scene.effect.Glow;
import java.util.Date;

/**
 @todo Buttons
 @todo Warning
 @todo Colors
 @todo Slide-in


 * @author tor
 */
var w = 500;
var h = 500;
var f = Font {
    size: 128
}

var player = javafx.scene.media.MediaPlayer{
    //autoPlay: true
    media: javafx.scene.media.Media {
        source: "{__DIR__}shut-up.mp3"
    }
}

var formatter = new java.text.SimpleDateFormat("m:ss");
var left = 0m on replace {
description = formatter.format(new Date(left.toMillis()));

};
var description;
def MAX = 9m + 59s;
left = MAX;

var color = Color.WHITE;
var fgcolor = Color.BLACK;
var y = 300;
var blink = Timeline {
    repeatCount: Timeline.INDEFINITE
    keyFrames: [
        KeyFrame {
            time: 500ms
            values: color => Color.RED
        }
        KeyFrame {
            time: 1s
            values: color => Color.WHITE
        }
        KeyFrame {
            time: 1500ms
            values: color => Color.RED
        }
    ]
}


var startButton: Button = Button {
    text: "Start"
    bg: Color.GREEN;
    translateX: 100;
    translateY: y;
    opacity: 1.0
    onMouseClicked: function(e : MouseEvent) {
        time.play();
        colortime.play();
        startButton.fadeout();
        //stopButton.fadein();

    }
}

var stopButton: Button = Button {
    text: "Stop"
    bg: Color.RED;
    translateX: 200;
    translateY: y;
    opacity: 1.0
    onMouseClicked: function(e : MouseEvent) {
        time.stop();
        colortime.stop();
        //stopButton.fadeout();
        startButton.fadein();
        player.stop();
        blink.stop();
    }
}

var resetButton: Button = Button {
    text: "Reset"
    bg: Color.YELLOW;
    fg: Color.BLACK;
    translateX: 300;
    translateY: y;
    opacity: 1.0
    onMouseClicked: function(e : MouseEvent) {
        left = 5m;
    }
}

var text = Text {
    font: f
    x: w / 2 - 150,
    y: h / 2 - 30
    stroke: bind fgcolor
    fill: bind fgcolor
    content: bind description
}

Stage {
    title: "STFU"
    width: w
    height: h
    fullScreen: true
    scene: Scene {
        fill: bind color
        content: [
            Counter {

            }

        ]

    }
}

var time: Timeline = Timeline {
    repeatCount: Timeline.INDEFINITE
    keyFrames: [
        KeyFrame {
            time: 1s
            action: function() {
                left = left.sub(1s);
                if (left == 8s) {
                    player.play();
                }
                if (left == 0m) {
                    time.stop();
                }
            }
        }
    ]
}

var colortime: Timeline = Timeline {
    repeatCount: 1
    keyFrames: [
        KeyFrame {
            time: 0s
            values: [ color => Color.WHITE,
                fgcolor => Color.BLACK ]
        },
        KeyFrame {
            time: MAX - 1m
            values: [ color => Color.WHITE,
                fgcolor => Color.BLACK ]
        },
        KeyFrame {
            time: MAX - 30s
            values: [ color => Color.YELLOW,
                fgcolor => Color.BLACK ]
        },
        KeyFrame {
            time: MAX - 1s
            values: [ color => Color.RED,
                fgcolor => Color.BLACK ]
        }
        KeyFrame {
            time: MAX
            values: [ color => Color.RED,
                fgcolor => Color.WHITE ]
            action: function() {
                time.stop();
                description = "STFU!";
                colortime.stop();
                blink.play();
            }
        }
    ]
}

