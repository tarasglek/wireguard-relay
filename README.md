This is a simple script designed to let 2 NATed wireguard peers to talk to each other.

This uses socat, so: 
`apt-get install socat`

`relay.sh <base_port> <count>`

will create <count> udp port pairs where odd/even ports are connected to each other.

So suppose you run this script on `public-relay.com`.

`relay.sh 5000 1`
Above command would bridge connections between port `public-relay.com:5000` and `public-relay.com:5001`.

So you'd set one wireguard instance to point at port `public-relay.com:5000` and the other at `public-relay.com:5001` and they would be able to talk each other.

Node a:
```
# Hub configuration created on wireguard on Fri Jan  8 06:06:30 UTC 2021
[Interface]
Address = 10.177.78.1/24
PrivateKey = AO+/A+ZJwIj5tKS329wMXaEluzmqRMYZfP5FaUF0jEM=
SaveConfig = false

[Peer]
PublicKey = A6oGfGRwMM2Bu4z2do3KuwNKy3uFpuyTqS6t9bQSX1U=
PresharedKey = 4ImjSJ013WY7qXnaaxeUEhvcdU4GEJG8O0ZgcCw+LwQ=
AllowedIPs = 10.177.78.11/32
Endpoint = public-relay.com:5000
```

Node b:
```
# 11: 11 > wgclient_11.conf
[Interface]
Address = 10.177.78.11/24
PrivateKey = iJHQgQO6K7vhaXDnaAO5rBX0V2UTMvsjfG96qOgj31E=

[Peer]
PublicKey = WZN+ubi/yS2Fm3KwGXO49f4Eb2mxEBKzhdNtRgJe3HQ=
PresharedKey = 4ImjSJ013WY7qXnaaxeUEhvcdU4GEJG8O0ZgcCw+LwQ=
AllowedIPs = 10.177.78.0/24
Endpoint = public-relay.com:5001
PersistentKeepalive = 25
```

To test this run a `ping 10.177.78.11` on node-a and `ping 10.177.78.1` on node-b

Alternatives:

* tailscale will do NAT traversal and proxing automatically.
* TURN servers sort of do this, but they require a more complicated handshake and packet format changes