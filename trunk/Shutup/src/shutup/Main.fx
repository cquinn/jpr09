package shutup;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import javafx.scene.paint.Color;
import javafx.scene.input.MouseEvent;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;

var player = javafx.scene.media.MediaPlayer {
    media: javafx.scene.media.Media {
        source: "{__DIR__}shut-up.mp3"
    }
}

var y = 50;

var ui:Counter = Counter {

    // When mouse moves, quickly fade in keyboard hints. A couple of seconds
    // after mouse stops moving, fade out keyboard hints at a normal rate.
    // If mouse moves during wait period, hints should remain visible and wait
    // period should restart.

    // Mouse click should start/stop

    // Keys to start/stop: space, enter, s
    // Keys to reset: r

    // Handle keyboard controls
    onKeyPressed: function(evt: KeyEvent): Void {
        //println(evt.code);

        if (evt.code == KeyCode.VK_SPACE
                or evt.code == KeyCode.VK_ENTER
                or evt.code == KeyCode.VK_S) {
            if (timeline.running) {
                stop()
            }
            else {
                start();
            }
        }
        else if (evt.code == KeyCode.VK_R or evt.code == KeyCode.VK_ESCAPE) {
            reset();
        }
        else if (evt.code == KeyCode.VK_0 or evt.code == KeyCode.VK_NUMPAD0) {
            reset(soundLeadTime);
        }
        else if (evt.code == KeyCode.VK_1 or evt.code == KeyCode.VK_NUMPAD1) {
            reset(1m);
        }
        else if (evt.code == KeyCode.VK_2 or evt.code == KeyCode.VK_NUMPAD2) {
            reset(2m);
        }
        else if (evt.code == KeyCode.VK_3 or evt.code == KeyCode.VK_NUMPAD3) {
            reset(3m);
        }
        else if (evt.code == KeyCode.VK_4 or evt.code == KeyCode.VK_NUMPAD4) {
            reset(4m);
        }
        else if (evt.code == KeyCode.VK_5 or evt.code == KeyCode.VK_NUMPAD5) {
            reset(5m);
        }
        else if (evt.code == KeyCode.VK_6 or evt.code == KeyCode.VK_NUMPAD6) {
            reset(6m);
        }
        else if (evt.code == KeyCode.VK_7 or evt.code == KeyCode.VK_NUMPAD7) {
            reset(7m);
        }
        else if (evt.code == KeyCode.VK_8 or evt.code == KeyCode.VK_NUMPAD8) {
            reset(8m);
        }
        else if (evt.code == KeyCode.VK_9 or evt.code == KeyCode.VK_NUMPAD9) {
            reset(9m);
        }
    }
}

function start(): Void {
    timeline.play();
    //colortime.play();
    startButton.fadeout();
    //stopButton.fadein();
}

var startButton: Button = Button {
    text: "Start"
    bg: Color.GREEN
    translateX: 50
    translateY: y
    opacity: 1.0
    onMouseClicked: function(e: MouseEvent) {
        start();
    }
}

function stop(): Void {
    timeline.stop();
    //colortime.stop();
    //stopButton.fadeout();
    startButton.fadein();
    player.stop();
    //blink.stop();
}

var stopButton: Button = Button {
    text: "Stop"
    bg: Color.RED
    translateX: 150
    translateY: y
    opacity: 1.0
    onMouseClicked: function(e: MouseEvent) {
        stop();
    }
}

function reset(newTime:Duration) {
    startTime = newTime;
    reset();
}


function reset(): Void {
    time = startTime;
    ui.show(time);
    stop();
}

var resetButton: Button = Button {
    text: "Reset"
    bg: Color.YELLOW
    fg: Color.BLACK
    translateX: 250
    translateY: y
    opacity: 1.0
    onMouseClicked: function(e: MouseEvent) {
        reset();
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

var soundLeadTime = 8s;
var startTime = 5m;
var time = startTime;

var timeline = Timeline {
    repeatCount: Timeline.INDEFINITE
    keyFrames: [
        KeyFrame {
            time: 1s
            action: function() {
                if (time == soundLeadTime) {
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

// Enable keyboard input
ui.requestFocus();

ui.show(time);