#!/usr/bin/env python
# encoding: utf-8
import sys
import chilkat

#  This example requires the Chilkat API to have been previously unlocked.
#  See Global Unlock Sample for sample code.

#  --------------------------------------------------
#  This example borrows the code from the REST using HTTP Proxy example.
#  We first use the Chilkat Socket object to establish a connection to the WebSocket server through an HTTP proxy.
#  Next, the Rest object uses the Socket object for its connection.
#  Finally, the WebSocket object uses the Rest object for its connection.
# 

rest = chilkat.CkRest()
socket = chilkat.CkSocket()

#  Set the HTTP proxy domain or IP address, and port.
socket.put_HttpProxyHostname("150.230.84.67")
socket.put_HttpProxyPort(8880)

#  Provide authentication to the HTTP proxy, if needed.
socket.put_HttpProxyUsername("HTTP_PROXY_LOGIN")
socket.put_HttpProxyPassword("HTTP_PROXY_PASSWORD")
socket.put_HttpProxyAuthMethod("Basic")

#  Indicate that HTTP requests (i.e. the WebSocket opening handshake) will be sent over the socket.
#  This is important for how the HTTP proxy connection is established.
socket.put_HttpProxyForHttp(True)

#  Connect to the websocket server through the HTTP proxy.
bTls = False
port = 80
maxWaitMs = 5000
success = socket.Connect("some-websocket-server.com",port,bTls,maxWaitMs)
if (success != True):
    print("Connect Failure Error Code: " + str(socket.get_ConnectFailReason()))
    print(socket.lastErrorText())
    sys.exit()

#  Tell the Rest object to use the connected socket.
success = rest.UseConnection(socket,True)
if (success != True):
    print(rest.lastErrorText())
    sys.exit()

ws = chilkat.CkWebSocket()

#  Tell the WebSocket to use this connection.
success = ws.UseConnection(rest)
if (success != True):
    print(ws.lastErrorText())
    sys.exit()

#  Add the standard WebSocket open handshake headers that will be needed.
#  (This adds the required HTTP request headers to the rest object.)
ws.AddClientHeaders()

#  Add any additional headers that might be desired.
#  Two common WebSocketSpecific headers are "Sec-WebSocket-Protocol" and "Origin".
rest.AddHeader("Sec-WebSocket-Protocol","x-some-websocket-subprotocol")
rest.AddHeader("Origin","http://some-websocket-server.com")

#  Do the open handshake.
responseBody = rest.fullRequestNoBody("GET","/something")
if (rest.get_LastMethodSuccess() != True):
    print(rest.lastErrorText())
    sys.exit()

#  If successful, the HTTP response status code should be 101,
#  and the response body will be empty. (If it failed, we'll have a look
#  at the response body..)
statusCode = rest.get_ResponseStatusCode()
print("Response status code: " + str(statusCode))

if (statusCode != 101):
    print(responseBody)
    print("-- Failed because of unexpected response status code.")
    sys.exit()

#  We have the expected 101 response, so let's now validate the
#  contents of the response, such as the value sent by the server in the
#  Sec-WebSocket-Accept header.
success = ws.ValidateServerHandshake()
if (success != True):
    print(ws.lastErrorText())
    sys.exit()

print("WebSocket connection successful.")

#  The application may now begin sending and receiving frames on the WebSocket connection.
#  (At this point, we're done with the rest and socket objects...)

print("Success.")
