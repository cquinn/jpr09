package
{
	import mx.formatters.Formatter;

	public class DurationFormatter extends Formatter
	{
		override public function format(value:Object):String {
			var millis:Number = new Number(value)
			
			var minutes:uint = millis / 60000
			var seconds:uint = (millis % 60000) / 1000
			
			var mins:String
			var secs:String
			
			mins = minutes <= 9 ? "0" + minutes : "" + minutes
			secs = seconds <= 9 ? "0" + seconds : "" + seconds
			
			return mins + ":" + secs 
		}
	}
}