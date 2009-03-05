/*
 * Flipper.fx
 *
 * Created on 03-Mar-2009, 03:03:45
 */

package shutup;

import javafx.animation.Interpolator;
import javafx.stage.Stage;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;
import javafx.scene.transform.Scale;
import javafx.scene.transform.Translate;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import javafx.scene.effect.PerspectiveTransform;
import java.lang.Math;
import javafx.scene.CustomNode;
import javafx.scene.Node;

/**
 * A flipper custom component node.
 *
 * <p><b>WARNING</b>: This is work in progress
 *
 * @author Peter Pilgrim
 */

public class Flipper extends CustomNode {


    /** The x coordinate */
    public var x: Number;
    /** The y coordinate */
    public var y: Number;
    /** The width of this custom node */
    public var width: Number = 100;
    /** The heigh of this custom node */
    public var height: Number = 100;

    /** The text of the successive flip panel */
    public var firstText: String = "7";
    /** The text of the previous flip panel */
    public var lastText: String = "6";
    /** The font style to share between the flip panell */
    public var font: Font = Font {
        size: 150
    }

    /** The rotation angle of the current flipper, which affects the internal perspective transform */
    public var angle: Number = 0 on replace {
        // FX.println("angle={angle}");

        var a = if ( angle >= 0 ) angle mod 360 else 360 - Math.abs(angle) mod 360;
        if ( a > 0 and a < 180 ) {
            // Comment out for now to help debug
            //            textNodeFirst.visible = true;
            //            textNodeLast.visible = false;
            textNodeFirst.clip = topClip;
            textNodeLast.clip  = bottomClip;
        }
        else {
            // Comment out for now to help debug
            //            textNodeFirst.visible = false;
            //            textNodeLast.visible = true;

            // THERE IS A VERY WEIRD BUG in the next line.
            // If the bottom clip is not dynamically ((re-)created as it is here then
            // it fails to clip the top panel. Strange! *PP* 04/Mar/2009
            bottomClip = Rectangle {
                x: bind x-width
                y: bind y
                width: bind width * 2.5
                height: bind height
            };
            textNodeFirst.clip = bottomClip;
            textNodeLast.clip  = topClip;
        }

        textNodeFirst.effect = getPT(angle);
        textNodeLast.effect = getPT(angle + 180);
    };

    /** The radius (fake depth) of the perspective transform */
    public var radius = 20;

    /** Calculates the perspective transform according to input angle in degrees */
    function getPT( t: Number) {
        var rads = Math.toRadians(t);
        return PerspectiveTransform {
            ulx: 0 - radius * Math.cos(rads)
            uly: (1 - height ) * Math.sin(rads)
            urx: width + radius * Math.cos(rads)
            ury: (1 - height ) * Math.sin(rads)
            llx: 0 + radius * Math.cos(rads)
            lly: height * Math.sin(rads)
            lrx: width - radius * Math.cos(rads)
            lry: height * Math.sin(rads)
        }
    }

    /** The master group of scenegraph node for this custom node */
    var masterGroup: Group;

    /** The top clipping area */
    var topClip = Rectangle {
        x: bind x-width
        y: bind y-height
        width: bind width * 2.5
        height: bind height
    };

    /** The bottom clipping area */
    var bottomClip = Rectangle {
        x: bind x-width
        y: bind y
        width: bind width * 2.5
        height: bind height
    };

    /** The text node of the upper flip panel */
    // *PP* This will go away and be replaced by an ImageView component
    var textNodeFirst: Text  = Text {
	    font: font;
    	stroke: Color.BLACK
    	fill: Color.BLACK
        textAlignment: TextAlignment.CENTER
    	x: bind x + width / 2
    	y: bind y + height
    	content: bind firstText
        clip: topClip;
    };

    /** The text node of the lower flip panel */
    // *PP* This will go away and be replaced by an ImageView component
    var textNodeLast: Text  = Text {
	    font: font;
    	stroke: Color.GREEN
    	fill: Color.GREEN
        textAlignment: TextAlignment.CENTER
    	x: bind x + width / 2
    	y: bind y + height
    	content: bind lastText
        clip: bottomClip
    };

    // TODO: *PP* WE probably need four of the Text Nodes / ImageView to render the flipper correctly.

    /**
    * creates the graphics nodes for this custom component
     */
    public override function create(): Node {

        textNodeLast.effect  = getPT(angle + 180);
        textNodeFirst.effect = getPT(angle);
        masterGroup = Group {
            content: [
                Rectangle {
                    x: bind x
                    y: bind y
                    width: bind width
                    height: bind height
                    fill: Color.HOTPINK
                },
                textNodeLast,
                textNodeFirst
            ]
        };
        return masterGroup;
    }
}


/** A Test function */
public function run(): Void {

    var STAGE_WIDTH = 600;
    var STAGE_HEIGHT = 600;
    var flipper: Flipper;
    var angle = 0;

    Stage {
        title: "MyApp"
        scene: Scene {
            width: STAGE_WIDTH
            height: STAGE_HEIGHT
            content: [
                Group {
                    content: [
                        flipper = Flipper {
                            translateX: 200
                            translateY: 300
                            font: Font {
                                size: 150
                            }
                            angle: bind angle;
                            width: 200
                            height: 200
                    }]
                }
            ]
        }
    }


    var t1 = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames: [
            KeyFrame {
                time: 0s
                canSkip: true
                values: [
                    angle => 180
                ]
            },
            KeyFrame {
                time: 4s
                canSkip: true
                values: [
                    angle => -180
                ]
            }
        ]
    }
    t1.play();
}

// End
