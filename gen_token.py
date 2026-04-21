#!/usr/bin/env python3
import jwt
import datetime

with open('AuthKey_PP57R568AX.p8', 'r') as f:
    private_key = f.read()

token = jwt.encode(
    {
        'iss': 'b2a00f88-3a8d-40d0-b148-1f1db92e10b7',
        'iat': datetime.datetime.utcnow(),
        'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=10),
        'aud': 'appstoreconnect-v1'
    },
    private_key,
    algorithm='ES256',
    headers={'kid': 'PP57R568AX'}
)
print(token)