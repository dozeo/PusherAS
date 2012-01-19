package com.dozeo.pusheras.events
{
	import flash.events.Event;
	
	/**
	 * @author 
	 */
	public class PusherChannelEvent extends Event
	{
		static public const SETUP_COMPLETE:String = 'setup_complete';
		static public const SETUP_FAILED:String = 'setup_failed';
		static public const SUBSCRIBED:String = 'subscribed';
		static public const SUBSCRIPTION_FAILED:String = 'subscription_failed';
		
		public function PusherChannelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{ 
			return new PusherChannelEvent(this.type, this.bubbles, this.cancelable);
		} 
		
		override public function toString():String 
		{ 
			return formatToString("PusherChannelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
