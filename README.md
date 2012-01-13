Pusher <http://pusher.com> ActionScript3 Client Library
=============

Small Library for Pusher connections from AS3 / Flash using the native event system.

… still in development

Usage
-------

    // create pusher options
    var pusherOptions:PusherOptionsVO = new PusherOptionsVO();
    pusherOptions.applicationKey = '7eb5f1182dcd61xxxxxxx';
    pusherOptions.origin = 'http://localhost/';

    // create pusher client and connect to server
    var pusher:Pusher = new Pusher(pusherOptions);
    pusher.connect();

Documents
-------
* [Publisher API Overview](http://pusher.com/docs/publisher_api_guide)
* [The Pusher Protocol](http://pusher.com/docs/pusher_protocol)