/*
 * Main.fx
 *
 * Created on Mar 3, 2009, 6:54:51 PM
 */

package jfxflubber;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.Font;

/**
 * @author jsondow
 */

Stage {
    title: "Application title"
    width: 250
    height: 80
    scene: Scene {
        content: Text {
            font : Font {
                size : 24
            }
            x: 10, y: 30
            content: "Application content"
        }
    }
}