package pusher_events
{
	import com.dozeo.pusheras.events.PusherEvent;
	
	public class PusherMouseEventData
	{
		private var _localX:Number;
		private var _localY:Number;
		private var _stageX:Number;
		private var _stageY:Number;
		private var _relativeX:Number;
		private var _relativeY:Number;
		
		public function get localX():Number
		{
			return _localX;
		}

		public function set localX(value:Number):void
		{
			_localX = value;
		}

		public function get localY():Number
		{
			return _localY;
		}

		public function set localY(value:Number):void
		{
			_localY = value;
		}

		public function get stageX():Number
		{
			return _stageX;
		}

		public function set stageX(value:Number):void
		{
			_stageX = value;
		}

		public function get stageY():Number
		{
			return _stageY;
		}

		public function set stageY(value:Number):void
		{
			_stageY = value;
		}

		public function get relativeX():Number
		{
			return _relativeX;
		}

		public function set relativeX(value:Number):void
		{
			_relativeX = value;
		}

		public function get relativeY():Number
		{
			return _relativeY;
		}

		public function set relativeY(value:Number):void
		{
			_relativeY = value;
		}


	}
}