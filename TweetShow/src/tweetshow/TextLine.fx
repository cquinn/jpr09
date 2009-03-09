/*
 * TextLine.fx
 *
 * Created on Mar 3, 2009, 7:07:54 PM
 */

package tweetshow;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.text.TextAlignment;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.effect.Glow;
import javafx.scene.input.MouseEvent;
import javafx.scene.text.TextOrigin;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;

/**
 * @author mattg
 */

public class TextLine extends CustomNode {

    public var theText : String;
    public var yPos : Number;
    public var bgColor : Color;
    public var tweeterPic : String;

    public override function create(): Node {

        return Group {

            translateX : 15;
            translateY : bind yPos;

            content: [
                Rectangle {
                    x: 0;
                    y: 0;
                    width: 970;
                    height: 48;
                    fill: bind bgColor;
                    arcHeight: 5;
                    arcWidth: 5;
                },
                ImageView {
                    fitHeight:48
                    fitWidth:48
                    image: Image {
                        url: tweeterPic
                    }
                },
                Text {
                    font: Font {
                        size: 16;
                    }
                    translateX: 55
                    translateY: 15;
                    fill: Color.BLACK;
                    content: bind theText
                    wrappingWidth: 910
                    
                },
            ]

        }

    }

}
