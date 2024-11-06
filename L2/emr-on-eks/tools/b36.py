#!/usr/bin/env python

import sys
import json


data = json.load(sys.stdin)


def base36encode(text):
    if len(text) == 0:
        raise ValueError('text must be a non-empty string')
    num = 0
    chars = list(text)
    shift = 0
    for ch in chars:
        num = num << 8 * shift
        shift = 1
        num += ord(ch)

    if num == 0:
        return "0"
    alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"
    chars = []
    while num:
        num, i = divmod(num, 36)
        chars.append(alphabet[i])
    chars.reverse()
    return "".join(chars)


result = {
    'value': base36encode(data['value'])
}

print(json.dumps(result))
