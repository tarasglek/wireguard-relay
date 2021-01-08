This is a simple script designed to let 2 NATed wireguard peers to talk to each other.

`relay.sh <base_port> <count>`

will create <count> udp port pairs where odd/even ports are connected to each other.

So suppose you run this script on `public-relay.com`.

`relay.sh 5000 1`
Above command would bridge connections between port `public-relay.com:5000` and `public-relay.com:5001`.

So you'd set one wireguard instance to port at port `5000` and the other at `5001` and they would be able to talk each other.

Alternatives:

* tailscale will do NAT traversal and proxing automatically.
* TURN servers sort of do this, but they require a more complicated handshake and packet format changes