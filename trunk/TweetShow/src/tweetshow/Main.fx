/*
 * Main.fx
 *
 * Created on Mar 3, 2009, 2:12:32 PM
 */

package tweetshow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import java.util.List;
import twitter4j.Status;
import javafx.scene.paint.Color;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import javafx.scene.shape.Rectangle;
import javafx.scene.Group;
import tweetshow.TextLine;
import java.util.Arrays;
import javafx.scene.transform.Translate;
import javafx.scene.input.MouseEvent;
import javafx.animation.transition.TranslateTransition;
import javafx.ext.swing.SwingTextField;
import javafx.scene.control.TextBox;
import javafx.ext.swing.SwingButton;

/**
 * @author mattg
 */

var tweeter: Tweeter = new Tweeter();

def minCheck = 2m;

def groupHeight = 50;

var tweetList: TextLine[] on replace {
    for(tweet in tweetList)
        FX.println("{tweet.theText}")
};

var numLines = bind sizeof tweetList;

var yPosition = bind (10 + (numLines * groupHeight));

var tweetGroup: Group;

var updateField : SwingTextField;

Stage {
    title: "TweetShow"
    width: 1050
    height: 800
    scene: Scene {
        content: [
                Rectangle {
                    width: 1040,
                    height: 800
                    fill: Color.DARKBLUE
                },
                Group {
                    content:
                        Rectangle {
                            x: 10,
                            y: 10
                            width: 980,
                            height: 680
                            fill: Color.WHITE
                        }

                },
                Group {
                    content: tweetGroup = Group {
                        content: bind tweetList;
                    }
                    clip: Rectangle {
                        x: 10
                        y:10
                        width: 980,
                        height: 680
                    }
                },
                Group {
                    translateX : 1000
                    translateY : 10
                    content: [
                        Rectangle {
//                            x: 1000,
//                            y: 10
                            width: 25,
                            height: 680
                            fill: Color.BLACK
                        },
                        // up button
                        Rectangle {
                            translateX: 0,
                            translateY: 0
                            width: 25, 
                            height: 25
                            fill: Color.LIGHTGREY
                            onMouseClicked: function( e: MouseEvent ):Void {
                                tweetGroup.translateY += 25
                            }
                        },
                        // down button
                        Rectangle {
                            translateX: 0,
                            translateY: 655
                            width: 25,
                            height: 25
                            fill: Color.LIGHTGREY
                            onMouseClicked: function( e: MouseEvent ):Void {
                                tweetGroup.translateY += -25
                            }
                        }
                    ]
                },
                Group {
                    translateX : 10
                    translateY: 685
                    content : [
                        Rectangle {
                            width: 980,
                            height: 50
                            fill: Color.DARKBLUE
                        },
                        updateField = SwingTextField {
                            translateY: 12
                            columns: 80
                            text: ""
                            editable: true

                        },
                        SwingButton {
                            translateX: 900
                            translateY: 10
                            text: "Update!"
                            action: function() {
                                tweeter.sendUpdate(updateField.text);
                                updateField.text = ""
                            }
                        }
                    ]
                }

            ]
        }
    }

    var inittime = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time: 0.1s
                action: function() {
                    var tweets = tweeter.getMyStatuses();
                    for( tweet in tweets ) {
                    var username;
                    if ((tweet as Status).getUser().getScreenName() == "")
                        username = (tweet as Status).getUser().getName()
                    else 
                        username = (tweet as Status).getUser().getScreenName();
                    insert
                        TextLine {
                            yPos: 10 + (groupHeight * numLines)//bind yPosition;
                            bgColor: if(numLines mod 2 == 0) Color.LIGHTGREY else Color.WHITE;
                            theText: "{username}: {(tweet as Status).getText()}";
                            tweeterPic: (tweet as Status).getUser().getProfileImageURL().toString();
                        }
                    into tweetList;
                    }
                }
            }
        ]
    }

    var time = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames: [
            KeyFrame {
                time: minCheck
                canSkip: true
                action: function() {
                    var newTweets: List = tweeter.getMyLastStatuses(minCheck.toMinutes());
                    for( tweet in newTweets ) {
                    insert
                        TextLine {
                            yPos: 10 + (groupHeight * indexof tweet);
                            bgColor: if((numLines + sizeof newTweets) mod 2 == 0) Color.LIGHTGREY else Color.WHITE;
                            theText: (tweet as Status).getText();
                            tweeterPic: (tweet as Status).getUser().getProfileImageURL().toString();
                        } before tweetList[0];
                    }
                    for(tweet in tweetList) {
                        tweet.yPos = 10 + (groupHeight * indexof tweet)//sizeof newTweets
                    }
                }
            }
        ]
    }

    inittime.play();
    time.play();