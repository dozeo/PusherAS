// Copyright (c) 2012 dozeo GmbH
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

package com.dozeo.pusheras.vo
{
	/**
	 * Pusher <http://pusher.com> Options Storage Object
	 * @author Tilman Griesel <https://github.com/TilmanGriesel> - dozeo GmbH <http://dozeo.com>
	 */
	public final class PusherOptions
	{
		private var _version:String = '2.1';
		private var _protocol:String = '5';
		private var _applicationKey:String;
		private var _origin:String;
		private var _secure:Boolean = false;
		private var _encrypted:Boolean = false;
		private var _protocols:Array = new Array();
		private var _proxyHost:String = '';
		private var _proxyPort:int = 0;
		private var _cookie:String = '';
		private var _headers:String = '';
		private var _host:String = 'ws.pusherapp.com';
		private var _ws_port:uint = 80;
		private var _wss_port:uint = 443;
		private var _auth_endpoint:String = '/pusher/auth';
		private var _activity_timeout:uint = 120000;
		private var _pong_timeout:uint = 30000;
		
		public function PusherOptions(applicationKey:String = null, origin:String = null):void 
		{ 
			this._applicationKey = applicationKey;
			this._origin = origin;
		}
		
		public function get version():String
		{
			return this._version;
		}
		
		public function get applicationKey():String
		{
			return this._applicationKey;
		}
		
		public function set applicationKey(value:String):void
		{
			this._applicationKey = value;
		}
		
		public function get origin():String
		{
			return this._origin;
		}
		
		public function set origin(value:String):void
		{
			this._origin = value;
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
		
		public function get protocols():Array
		{
			return this._protocols;
		}
		
		public function set protocols(value:Array):void
		{
			this._protocols = value;
		}
		
		public function get proxyHost():String
		{
			return this._proxyHost;
		}
		
		public function set proxyHost(value:String):void
		{
			this._proxyHost = value;
		}
		
		public function get proxyPort():int
		{
			return this._proxyPort;
		}
		
		public function set proxyPort(value:int):void
		{
			this._proxyPort = value;
		}

		public function get cookie():String
		{
			return this._cookie;
		}
		
		public function set cookie(value:String):void
		{
			this._cookie = value;
		}
		
		
		public function get headers():String
		{
			return this._headers;
		}
		
		public function set headers(value:String):void
		{
			this._headers = value;
		}
		
		public function get host():String
		{
			return this._host;
		}
		
		public function set host(value:String):void
		{
			this._host = value;
		}
		
		public function get ws_port():uint
		{
			return this._ws_port;
		}
		
		public function set ws_port(value:uint):void
		{
			this._ws_port = value;
		}
		
		public function get wss_port():uint
		{
			return this._wss_port;
		}
		
		public function set wss_port(value:uint):void
		{
			this._wss_port = value;
		}
		
		public function get auth_endpoint():String
		{
			return this._auth_endpoint;
		}
		
		public function set auth_endpoint(value:String):void
		{
			this._auth_endpoint = value;
		}
		
		public function get activity_timeout():uint
		{
			return this._activity_timeout;
		}
		
		public function set activity_timeout(value:uint):void
		{
			this._activity_timeout = value;
		}
		
		public function get pong_timeout():uint
		{
			return this._pong_timeout;
		}
		
		public function set pong_timeout(value:uint):void
		{
			this._pong_timeout = value;
		}
		
		// Logic Getters
		
		public function get connectionPath():String
		{
			return	'/app/' + _applicationKey + "?client=js&version=" + _version + '&protocol=' + _protocol;
		}

		public function get pusherURL():String
		{
			return	'ws://' + _host + ":" + _ws_port + connectionPath;
		}
		
		public function get pusherSecureURL():String
		{
			return	'wss://' + _host + ":" + _wss_port + connectionPath;
		}
		
	}
}