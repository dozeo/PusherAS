// Copyright (c) 2012 dozeo GmbH
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

package com.dozeo.pusheras
{
	import com.adobe.serialization.json.JSON2;
	import com.adobe.serialization.json.JSONDecoder;
	import com.dozeo.pusheras.channel.PusherChannel;
	import com.dozeo.pusheras.events.PusherChannelEvent;
	import com.dozeo.pusheras.events.PusherEvent;
	import com.dozeo.pusheras.logger.WebSocketLogger;
	import com.dozeo.pusheras.utils.PusherConstants;
	import com.dozeo.pusheras.vo.PusherOptions;
	import com.dozeo.pusheras.vo.PusherStatus;
	import com.dozeo.pusheras.vo.WebsocketStatus;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import net.websocket.IWebSocketLogger;
	import net.websocket.WebSocket;
	import net.websocket.WebSocketEvent;
	import net.websocket.WebSocketFrame;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	/**
	 * Pusher <http://pusher.com> ActionScript3 Client Library
	 * @author Tilman Griesel <https://github.com/TilmanGriesel> - dozeo GmbH <http://dozeo.com>
	 */
	public class Pusher extends EventDispatcher
	{
		private static const logger: ILogger = getLogger( Pusher );
		
		private static const VERSION:String = '0.1.4';
		
		private var _verboseLogging:Boolean = false;
		
		// pusheras vars
		private var _pusherOptions:PusherOptions;
		private var _pusherStatus:PusherStatus;
		
		// websocket vars
		private var _websocket:WebSocket;
		private var _websocketStatus:WebsocketStatus;
		
		// channel bucket
		protected var _channelBucket:Array;
		
		/**
		 * @param options all required options for the pusher connection
		 * */
		public function Pusher(options:PusherOptions)
		{
			logger.info('construct');
			
			// parameter check
			if(options == null)
				throw new Error('options cannot be null');
			
			// store options
			_pusherOptions = options;
			
			// create small storage object for the websocket and pusher status
			_websocketStatus = new WebsocketStatus();
			_pusherStatus = new PusherStatus();
			
			// create channel bucket
			_channelBucket = new Array();
			
			this.addEventListener(PusherEvent.CONNECTION_ESTABLISHED, this_CONNECTION_ESTABLISHED);
		}

		public function connect():void
		{
			logger.info('connecting...');
			
			// connect to websocket server
			connectWebsocket();
		}
		
		/**
		 * inital websocket connection
		 * */
		private function connectWebsocket():void
		{
			// check for websocket status storage object
			if(_websocketStatus == null)
				throw new Error('websocket status cannot be null');

			// check for pusher status storage object
			if(_pusherStatus == null)
				throw new Error('pusher status cannot be null');
			
			// check if connection attempt is already in progress
			if(_websocketStatus.connecting)
			{
				log('Already attempting connection. Aborting...');
				return;
			}
			
			// check if websocket is already connected
			if(_websocketStatus.connected)
			{
				log('Connection is already established. Aborting connection attempt...');
				return;
			}
			
			logger.info('environment checked. connecting...');
			
			// update status
			_pusherStatus.connecting = true;
			_websocketStatus.connecting = true;
			
			// get pusher url
			var pusherURL:String;
			if(_pusherOptions.encrypted || _pusherOptions.secure)
				pusherURL = _pusherOptions.pusherSecureURL;
			else
				pusherURL = _pusherOptions.pusherURL;
			
			// create websocket instance
			_websocket = new WebSocket(_websocketStatus.connectionIndex,
										pusherURL,
										_pusherOptions.protocols,
										_pusherOptions.origin,
										_pusherOptions.proxyHost,
										_pusherOptions.proxyPort,
										_pusherOptions.cookie,
										_pusherOptions.headers,
										new WebSocketLogger(_verboseLogging));
			
			// add websocket event listeners
			_websocket.addEventListener(WebSocketEvent.OPEN, _websocket_OPEN);
			_websocket.addEventListener(WebSocketEvent.CLOSE, _websocket_CLOSE);
			_websocket.addEventListener(WebSocketEvent.ERROR, _websocket_ERROR);
			_websocket.addEventListener(WebSocketEvent.MESSAGE, _websocket_MESSAGE);
			
		}
		
		protected function _websocket_OPEN(event:WebSocketEvent):void
		{
			logger.info('websocket open');
			
			// store status
			_websocketStatus.connected = true;			
		}
		
		protected function _websocket_CLOSE(event:WebSocketEvent):void
		{
			logger.info('websocket close: ' + unescape(event.message));
			
			// store status
			_websocketStatus.connected = false;
		}
		
		protected function _websocket_ERROR(event:WebSocketEvent):void
		{
			logger.error('websocket error: ' + unescape(event.message));
			
			// store status
			_websocketStatus.connected = false;
		}
		
		protected function _websocket_MESSAGE(event:WebSocketEvent):void
		{
			if(_verboseLogging)
			{
				logger.info('websocket message: ' + unescape(event.message));	
			}
			
			
			// try to parse new pusher event from websocket message
			try
			{
				var pusherEvent:PusherEvent = PusherEvent.parse(unescape(event.message));				
			}
			catch(e:Error)
			{
				logger.error('websocket message parsing error: ' + e.message + ' | message: ' + unescape(event.message));
				return;
			}
			
			// look in the channel bucket if channel subscribed and dispatch event on it
			// very simple logic with great performance
			if(pusherEvent.channel != null)
			{
				for(var i:int = 0; i < _channelBucket.length; i++)
				{
					var channel:PusherChannel = _channelBucket[i] as PusherChannel;
					if(channel.name == pusherEvent.channel)
					{
						channel.dispatchEvent(pusherEvent);
					}
				}
			}
			else
			{
				// redispatch pusher event
				this.dispatchEvent(pusherEvent);
			}		
		}
		
		protected function this_CONNECTION_ESTABLISHED(event:PusherEvent):void
		{
			logger.info('websocket connection established. socket id: ' + event.data.socket_id);
			
			_pusherStatus.connected = true;
						
			if(event.data.hasOwnProperty('socket_id'))
				_websocketStatus.socketID = event.data.socket_id;
		}
		
		/**
		 * Subscribes a pusher channel with the given name.
		 * add native event listeners to it
		 * @param channelName The name of your channel
		 * @return a channel instance for event listening and dispatching
		 */	
		public function subscribe(channelName:String):PusherChannel
		{
			// check the pusher connection
			if(_pusherStatus.connected == false)
				throw new Error('cannot subscribe "' + channelName + '" because the pusher service is not connected!');
			
			// pusher channel implentation
			var pusherChannel:PusherChannel;
			
			// define channel type
			if(channelName.indexOf(PusherConstants.CHANNEL_NAME_PRIVATE_PREFIX) != -1)
			{
				logger.info('subscribing private channel "' + channelName + '"...'); 
				pusherChannel = new PusherChannel(PusherChannel.PRIVATE, channelName, dispatchPusherEvent, true, _websocketStatus.socketID, _pusherOptions.auth_endpoint);
			}
			else
			{
				logger.info('subscribing public channel "' + channelName + '"...'); 
				pusherChannel = new PusherChannel(PusherChannel.PUBLIC, channelName, dispatchPusherEvent);
			}
			
			// add internal channel event listeners
			pusherChannel.addEventListener(PusherChannelEvent.SETUP_COMPLETE, pusherChannel_SETUP_COMPLETE);
			
			// initialize channel (perform auth request etc.)
			pusherChannel.init();
			
			return pusherChannel;
		}
		
		/**
		 * subscribe channel after setup complete event
		 * */
		protected function pusherChannel_SETUP_COMPLETE(event:Event):void
		{
			// get channel
			var pusherChannel:PusherChannel = event.target as PusherChannel;
			
			// create new channel object
			_channelBucket.push(pusherChannel);
			
			// create new pusher event
			var pusherEvent:PusherEvent = new PusherEvent(PusherEvent.SUBSCRIBE);
			pusherEvent.data.channel = pusherChannel.name;
			pusherEvent.data.auth = _pusherOptions.applicationKey + ':' + pusherChannel.authenticationSignature;
			
			// dispatch event to pusher service
			dispatchPusherEvent(pusherEvent);
		}
		
		/**
		 * Remove and unsubscribe channel
		 * */
		public function unsubscribe(channelName:String):void
		{
			// create new pusher event
			var pusherEvent:PusherEvent = new PusherEvent(PusherEvent.UNSUBSCRIBE);
			pusherEvent.data.channel = channelName;
			
			// search for channel in bucket
			for(var i:int = 0; i < _channelBucket.length; i++)
			{
				var channel:PusherChannel = _channelBucket[i] as PusherChannel;
				if(channel.name == pusherEvent.channel)
				{
					// remove channel from bucket
					_channelBucket.splice(i, 1);
				}
			}
		}
		
		/**
		 * dispatch event to pusher service
		 * **/
		public function dispatchPusherEvent(event:PusherEvent):void
		{
			// check websocket connection
			if(_websocketStatus.connected == false)
			{
				logger.warn('websocket is not connected... cannot send event!');
				//throw new Error('websocket is not connected, cannot send event');
			}
			
			try
			{
				if(_verboseLogging) logger.info('send >> ' + event.toJSON());
				_websocket.send(event.toJSON());
			}
			catch(e:Error)
			{
				log('pusher event dispatching failed: ' + e.message);
			}
		}
		
		/**
		 * Event Logging
		 * ToDo
		 * */
		private var _loggingEnabled:Boolean = true;
		private function log(msg:String):void
		{
			if(_loggingEnabled)
			{
				trace('LOG: ' + msg);
			}
		}
		
		public function get pusherStatus():PusherStatus
		{
			return _pusherStatus;
		}

		public function get verboseLogging():Boolean
		{
			return _verboseLogging;
		}

		public function set verboseLogging(value:Boolean):void
		{
			_verboseLogging = value;
		}

	}
}
