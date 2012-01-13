package com.dozeo.pusheras.pusher.vo
{
	/**
	 * @author Tilman Griesel - dozeo GmbH
	 */
	public final class PusherOptions
	{
		private var _secure:Boolean;
		private var _encrypted:Boolean;
		
		public function PusherOptions(secure:Boolean = null, encrypted:Boolean = null):void 
		{ 
			this._secure = secure;
			this._encrypted = encrypted;
		}
		
		public function get secure():Boolean
		{
			return this._secure;
		}
		
		public function set secure(value:Boolean):void
		{
			this._secure = value;
		}
		
		public function get encrypted():Boolean
		{
			return this._encrypted;
		}
		
		public function set encrypted(value:Boolean):void
		{
			this._encrypted = value;
		}
		
	}
}