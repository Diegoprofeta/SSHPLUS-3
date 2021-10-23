#!/usr/bin/env python
import socket  
import hashlib
import base64

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
sock.bind(("", 80))  
sock.listen(5)  

WS_MAGIC = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"
HandShaken = False
print "TCPServer Waiting for client on port 9999"  


header = ''
tmp = ''
isInFrame = False
frame_fin = False
frame_rsv = ''
frame_opcode = 0
frame_masked = True
frame_mask_array = []
frame_payloadlen1 = 0
frame_header_len = 0
frame_len = 0

def packFrame(data):
    ''' simple pack text frame '''

    # first byte 
    b0 = 0
    b0 |= (1<<7)  # fin 
    b0 |= 0 << 4  # rsv
    b0 |= 1       # opcode

    # second byte , payload length and mask
    b1 = 0
    l = len(data)
    if l <= 125:
        b1 |= l
    else:
        raise Exception('data length too long , haven\'t support yet')

    raw = ''.join([chr(b0),chr(b1),data])
    return raw



client , address = sock.accept()

while True:

    if HandShaken == False:  
        header += client.recv(16)  
        end_of_header = header.find("\x0d\x0a\x0d\x0a")
        if end_of_header >= 0:
            print header
            raw = header[:end_of_header].splitlines()
            http_status_line = raw[0].strip()
            http_headers = {}
            for h in raw[1:]:
                i = h.find(':')
                if i>0:
                    key = h[:i].strip()
                    value = h[i+1:].strip()
                    http_headers[key] = value.decode('utf-8')

            sec_websocket_accept_got = http_headers["Sec-WebSocket-Key"].strip()
            key = http_headers["Sec-WebSocket-Key"].strip()
            sha1 = hashlib.sha1()
            sha1.update(key + WS_MAGIC)
            sec_websocket_accept = base64.b64encode(sha1.digest())
            response  = "HTTP/1.1 101 Switching Protocols\x0d\x0a"
            response += "Upgrade: websocket\x0d\x0a"
            response += "Connection: Upgrade\x0d\x0a"
            response += "Sec-WebSocket-Accept: %s\x0d\x0a" % sec_websocket_accept
            response += "Sec-WebSocket-Protocol: %s\x0d\x0a" % http_headers["Sec-WebSocket-Protocol"]
            response += "\x0d\x0a"
            client.send(response)
            HandShaken = True
    else:
        tmp += client.recv(16)
        print('tmp length: '+str(len(tmp)))
        if not isInFrame :
            b = ord(tmp[0])

            # FIN RSV OPCODE
            frame_fin = (b & 0x80) != 0
            frame_rsv = (b & 0x70) >> 4
            frame_opcode = b & 0x0f
            print('frame_fin: '+ str(frame_fin))
            print('frame_rsv: '+ str(frame_rsv))
            print('frame_opcode: '+str(frame_opcode))

            #mask payload length
            b = ord(tmp[1])
            frame_masked = (b & 0x80) != 0
            frame_payload_len = b & 0x7f

            print('frame_masked: '+ str(frame_masked))
            print('frame_payload_len: '+str(frame_payload_len))

            if frame_masked:
                mask_len = 4
            else:
                mask_len = 0

            frame_header_len = 2+mask_len
            print('frame_header_len: '+str(frame_header_len))

            if len(tmp) >= frame_header_len:
                i = 2
                frame_mask = None
                if frame_masked:
                    frame_mask = tmp[i:i+4]
                for j in range(0, 4):
                    frame_mask_array.append(ord(frame_mask[j]))
                i += 4

                frame_len = frame_header_len + frame_payload_len
                isInFrame = True
        elif len(tmp) >= frame_len:
            data = tmp[frame_header_len:frame_len]
            payload = bytearray(data)
            if frame_masked:
               for k in xrange(0, frame_payload_len):
                  payload[k] ^= frame_mask_array[ k % 4]

            print('payload is: '+payload)
            tmp = tmp[frame_len:]
            isInFrame = False
            frame_fin = False
            frame_rsv = ''
            frame_opcode = 0
            frame_masked = True
            frame_mask_array = []
            frame_payloadlen1 = 0
            frame_header_len = 0
            frame_len = 0
            client.send(packFrame('hello, browser'))
