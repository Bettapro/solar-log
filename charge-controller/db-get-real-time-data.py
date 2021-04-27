#!/usr/bin/python
import json
import pymysql
import sys, os


def json_serial(obj):
    return str(obj)
    
    
def find_charge_controller_def(controller_def, field):
    for define in controller_def:
        if define["field"] == field :
            return define
    return 0

def find_charge_controller_type(controller_def, field):
    if field in controller_def:
        return controller_def[field]
    return 0
        

result = {"error": "unknown"}

floatDataValues = ["amps", "volts", "watts", "temperature", "percent"]

try:
    with open("charge-controller.json", mode="r", encoding="utf-8") as data:
        chargeController = json.load(data)
    with open("db-config.json", mode="r", encoding="utf-8") as f:
        db = json.load(f)

    conn = pymysql.connect(
    	db=db["db"],
    	user=db["user"],
    	password=db["password"],
    	host=db["host"]
    )

    c = conn.cursor()
    result = {"hour": []}
    for tableName in chargeController["data"]:
        if tableName == "controller_real_time_data" or tableName == "controller_real_time_status" or tableName == "controller_settings":
            rowResult = {}
            sql = "SELECT * FROM %s ORDER BY create_date DESC LIMIT 1" % tableName
            c.execute(sql)
            row = c.fetchone()
            fields = []
            for field in c.description:
                fields.append(field[0])
            for i in range(len(fields)):
                data_def = find_charge_controller_def(chargeController["data"][tableName], fields[i])
                
                if ( data_def != 0 and ( "type" in data_def ) and( data_def["type"] in floatDataValues ) ) :
                    rowResult[fields[i]] = float(row[i])
                    
                    type_def = find_charge_controller_type(chargeController["types"], data_def["type"])
                    
                    
                    if ( type_def != 0 and "uimultiplier" in type_def ):
                        rowResult[fields[i]] = rowResult[fields[i]] * type_def["uimultiplier"]
                    if ( type_def != 0 and "uioffset" in type_def ):
                        rowResult[fields[i]] = rowResult[fields[i]] + type_def["uioffset"]
                else:
                    rowResult[fields[i]] = row[i]
            result[tableName] = rowResult

    # Get a brief history...
    # Get {maxRecords} records representing the past {durationMiutes} minutes, grouped by {groupSeconds}
    secondsInADay = 24 * 60 * 60
    maxRecords = 60//86400
    durationMinutes = 60
    groupSeconds = (durationMinutes * 60) / (maxRecords - 1)
    parms = {"groupSeconds": groupSeconds, "duration": durationMinutes, "decimals": 2, "day": secondsInADay}

    with open("sql/recent-trends.sql", mode="r", encoding="utf-8") as f:
        sql = f.read();
    c.execute(sql.format(**parms))
    #c.execute(sql)
    result["hour_fields"] = [
        "create_date",
        "rt_input_v",
        "rt_input_a",
        "rt_input_w",
        "rt_battery_v",
        "rt_battery_a",
        "rt_battery_w",
        "rt_battery_soc",
        "rt_battery_temp",
        "rt_remote_battery_temp",
        "rt_power_component_temp",
        "rt_case_temp",
        "rt_load_v",
        "rt_load_a",
        "rt_load_w"
    ]
    for rowObj in c:
        row = list(rowObj)
        for i in range(len(row)):
            field_def = find_charge_controller_def(chargeController["data"]["controller_real_time_data"], result["hour_fields"][i])
            if ( field_def != 0 and ( "type" in field_def ) and( field_def["type"] in floatDataValues ) ) :
                row[i] = float(row[i])
        result["hour"].append(row)


    conn.commit()
    c.close()
except Exception as e:
    exception_type, exception_object, exception_traceback = sys.exc_info()
    result = {"error": str(e), "type": type(e), "trace" : exception_traceback.tb_lineno}

print("Content-Type: application/json")
print()
print(json.dumps(result, default=json_serial, sort_keys = True, indent = 2))
