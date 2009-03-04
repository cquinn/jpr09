/*
 * Counter.fx
 *
 * Created on Mar 2, 2009, 7:18:38 PM
 */

package shutup;

public class Counter extends ShutupUI {
    var minsArray = [
        leftText0,
        leftText1,
        leftText2,
        leftText3,
        leftText4,
        leftText5,
        leftText6,
        leftText7,
        leftText8,
        leftText9,
        leftText10,
        leftText11,
        leftText12,
    ];

    var secsArray = [
        rightText00,
        rightText01,
        rightText02,
        rightText03,
        rightText04,
        rightText05,
        rightText06,
        rightText07,
        rightText08,
        rightText09,

        rightText10,
        rightText11,
        rightText12,
        rightText13,
        rightText14,
        rightText15,
        rightText16,
        rightText17,
        rightText18,
        rightText19,

        rightText20,
        rightText21,
        rightText22,
        rightText23,
        rightText24,
        rightText25,
        rightText26,
        rightText27,
        rightText28,
        rightText29,

        rightText30,
        rightText31,
        rightText32,
        rightText33,
        rightText34,
        rightText35,
        rightText36,
        rightText37,
        rightText38,
        rightText39,

        rightText40,
        rightText41,
        rightText42,
        rightText43,
        rightText44,
        rightText45,
        rightText46,
        rightText47,
        rightText48,
        rightText49,

        rightText50,
        rightText51,
        rightText52,
        rightText53,
        rightText54,
        rightText55,
        rightText56,
        rightText57,
        rightText58,
        rightText59,
    ];

    public function show(d: Duration) {
        var mins = d.toMinutes() as Integer;
        var seconds = d.toSeconds() as Integer;
        var remainder = seconds mod 60;

        for (i in [0..12]) {
            var visible = i == mins;
            minsArray[i].visible = visible;
        }

        for (i in [0..59]) {
            var visible = i == remainder;
            secsArray[i].visible = visible;
        }
    }


}
