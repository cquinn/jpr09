package shutup;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import javafx.scene.paint.Color;
import javafx.scene.input.MouseEvent;

var player = javafx.scene.media.MediaPlayer {
    media: javafx.scene.media.Media {
        source: "{__DIR__}shut-up.mp3"
    }
}

var y = 50;

var ui = Counter {
}

var startButton: Button = Button {
    text: "Start"
    bg: Color.GREEN;
    translateX: 50;
    translateY: y;
    opacity: 1.0
    onMouseClicked: function(e : MouseEvent) {
        timeline.play();
        //colortime.play();
        startButton.fadeout();
        //stopButton.fadein();

    }
}

var stopButton: Button = Button {
    text: "Stop"
    bg: Color.RED;
    translateX: 150;
    translateY: y;
    opacity: 1.0
    onMouseClicked: function(e : MouseEvent) {
        timeline.stop();
        //colortime.stop();
        //stopButton.fadeout();
        startButton.fadein();
        player.stop();
        //blink.stop();

    }
}

var resetButton: Button = Button {
    text: "Reset"
    bg: Color.YELLOW;
    fg: Color.BLACK;
    translateX: 250;
    translateY: y;
    opacity: 1.0
    onMouseClicked: function(e : MouseEvent) {
        time = START_TIME;
        ui.show(time);
    }
}


Stage {
    title: "Application title"
    fullScreen: true
    scene: Scene {
        content: [
            ui,
            startButton,
            stopButton,
            resetButton
        ]
    }
}

var START_TIME = 5m;
var time = START_TIME;

var timeline = Timeline {
    repeatCount: Timeline.INDEFINITE
    keyFrames: [
        KeyFrame {
            time: 1s
            action: function() {
                if (time == 8s) {
                    player.play();
                }
                if (time > 0s) {
                    time = time.sub(1s);
                }
                ui.show(time);
            }
        }
    ]
}

ui.show(time);