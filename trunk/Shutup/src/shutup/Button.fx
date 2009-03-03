/*
    * Button.fx
     *
     * Created on Mar 2, 2009, 2:27:52 PM
     */

package shutup;

import javafx.scene.CustomNode;
import javafx.scene.effect.DropShadow;
import javafx.scene.effect.Glow;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.shape.Rectangle;
import javafx.scene.Group;
import javafx.scene.effect.DropShadow;
import javafx.scene.input.MouseEvent;
import javafx.scene.effect.Glow;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;

/**
* @author tor
 */

public class Button extends CustomNode {

    var buttonEffect: javafx.scene.effect.Effect = DropShadow {
        offsetX: 3
        offsetY: 3
    }
    public var buttonOpacity = 1.0;
    public var text = "Set me";
    public var bg = Color.GREEN;
    public var fg = Color.WHITE;

    public function fadeout(): Void {
        var fadeout = Timeline {
            repeatCount: 1
            keyFrames: [
                KeyFrame {
                    time: 0s
                    values: buttonOpacity => 1.0
                }
                KeyFrame {
                    time: 2s
                    values: buttonOpacity => 0.0
                }
            ]
        }
        fadeout.play();
    }

    public function fadein(): Void {
        var fadein = Timeline {
            repeatCount: 1
            keyFrames: [
                KeyFrame {
                    time: 0s
                    values: buttonOpacity => 0.0
                }
                KeyFrame {
                    time: 2s
                    values: buttonOpacity => 1.0
                }
            ]
        }
        fadein.play();
    }

    public override function create(): Node {
        return {
            Group {
                opacity: bind buttonOpacity
                onMousePressed: function(e : MouseEvent) {
                    buttonEffect = Glow {
                    }
                    e.node.translateX += 5;
                    e.node.translateY += 5;

                }
                onMouseReleased: function(e : MouseEvent) {
                    buttonEffect =  DropShadow {
                        offsetX: 3
                        offsetY: 3
                    }
                    e.node.translateX -= 5;
                    e.node.translateY -= 5;
                }
                content: [
                    Rectangle {
                        x: 0;
                        y: 0;
                        fill: bind bg;
                        width: 85
                        height: 40
                        arcWidth: 20
                        arcHeight: 20
                        effect: bind buttonEffect
                    }
                    Text {
                        font: Font {
                            size: 24
                        }
                        x: 18
                        y: 27
                        //stroke: Color.WHITE
                        fill: bind fg
                        content: bind text
                    },
                ]

            }
        }
    }
}
