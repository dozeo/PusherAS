package com.dozeo.pusheras.utils
{
	import com.adobe.serialization.json.JSON;
	import com.dozeo.pusheras.events.PusherEvent;

	public class PusherEventParser
	{
		public function PusherEventParser()
		{
		}
		
		public static function parse(pusherEventMessage:String):void
		{
			// check for an empty string
			if(pusherEventMessage == '')
				throw new Error('Pusher event message cannot be emtpy!');
			
			// decode event message
			var rawMessageObject:Object = JSON.decode(pusherEventMessage);
			var pusherEvent:PusherEvent = new PusherEvent();
			
			
		}
	}
}