// Copyright (c) 2012 dozeo GmbH
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

package com.dozeo.pusheras.utils
{	
	/**
	 * Contains constants related to working with Pusher.
	 * @author Shawn Makinson, squareFACTOR, www.squarefactor.com / Tilman Griesel <https://github.com/TilmanGriesel> - dozeo GmbH <http://dozeo.com>
	 */
	public final class PusherConstants
	{
		
		static public const CHANNEL_NAME_PRIVATE_PREFIX:String = "private-";
		static public const CHANNEL_NAME_PRESENCE_PREFIX:String = "presence-";
		
		/**
		 * @private
		 * The end user should not need to use this prefix since the methods auto prepend it. 
		 */		
		static public const CLIENT_EVENT_NAME_PREFIX:String = "client-";
		
		static public const CONNECTION_ESTABLISHED_EVENT_NAME:String = "pusher:connection_established";
		static public const CONNECTION_DISCONNECTED_EVENT_NAME:String = "pusher:connection_disconnected";
		static public const CONNECTION_FAILED_EVENT_NAME:String = "pusher:connection_failed";
		static public const ERROR_EVENT_NAME:String = "pusher:error";
		
		static public const SUBSCRIPTION_SUCCEEDED_EVENT_NAME:String = "pusher:subscription_succeeded";
		static public const MEMBER_ADDED_EVENT_NAME:String = "pusher:member_added";
		static public const MEMBER_REMOVED_EVENT_NAME:String = "pusher:member_removed";
		
		// End user should not need these since they can call methods that use these.
		static public const SUBSCRIBE_EVENT_NAME:String = "pusher:subscribe";
		static public const UNSUBSCRIBE_EVENT_NAME:String = "pusher:unsubscribe";
	}
}