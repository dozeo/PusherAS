Pusher <http://pusher.com> ActionScript3 Client Library
=============

AS3 Pusher Protocol implementation using the Native AS3 Event System.
Feel free to modify and update this lib if you find some bugs. How the protocol works is described in this article: http://pusher.com/docs/pusher_protocol.

Usage
-------

    public function PusherASExample()
    {
        // create pusher options
        var pusherOptions:PusherOptions = new PusherOptions();
        pusherOptions.applicationKey = '7eb5f11xxxxxxxxxxx';
        pusherOptions.origin = 'http://localhost/';
        
        // create pusher client and connect to server
        _pusher = new Pusher(pusherOptions);
        _pusher.addEventListener(PusherEvent.CONNECTION_ESTABLISHED, pusher_CONNECTION_ESTABLISHED);
        _pusher.connect();
    }

    /**
     * On successful connection subscribe a new channel and hear for events
     * */
    protected function pusher_CONNECTION_ESTABLISHED(event:PusherEvent):void
    {
        var testChannel:PusherChannel = _pusher.subscribe('test_channel');
        testChannel.addEventListener('MY_EVENT', testChannel_MY_EVENT);
    }

    /**
     * Pusher "testChannel" Event Listener
     * */
    protected function testChannel_MY_EVENT(event:PusherEvent):void
    {
        trace('YEAH... MY EVENT WAS DISPATCHED! ;D Event: ' + event.toJSON());
    }

Documents
-------
* [Publisher API Overview](http://pusher.com/docs/publisher_api_guide)
* [The Pusher Protocol](http://pusher.com/docs/pusher_protocol)
