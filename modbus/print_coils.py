#!/usr/bin/python
import json
from common import *

def readCoil(addressInfo):
    result = client.read_coils(addressInfo["id"], 1, unit=CHARGE_CONTROLLER_UNIT)
    if isinstance(result, Exception):
        addressInfo["error"] = true
        addressInfo["details"] = result
    else:
        addressInfo["function_code"] = result.function_code
        if result.function_code < 0x80:
            addressInfo["bits"] = list(result.bits)
            format = addressInfo["format"]
            addressInfo["value"] = result.bits[0]
            addressInfo["text"] = bitsAsText(result.bits, format)
        else:
            addressInfo["error"] = "Unable to read coil"
    return addressInfo

with open("address.json", "r") as f:
  address = json.load(f)

def asCoilWithData(id):
    return readCoil(address["byId"][str(id)]);

client = getClient()
if client.connect():
    mapped = map(asCoilWithData, address["coilIds"])
    print(json.dumps(list(mapped), indent=4))
    client.close()
else:
    print(json.dumps({"error": "unable to connect"}))