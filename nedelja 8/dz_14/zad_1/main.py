from device_model import Device_model

device_models=Device_model.read_device_model_atributes_from_database()
for device_model in device_models:
    print(device_model.model_name)
num=Device_model.count_device_models_from_database()
print(f"Broj device_modela u bazi podataka je: {num}")
print("_______________________________________________")


device_model=Device_model.create_new_device_model("novi_model","0002",15,1,1,1,1,1)
device_models=Device_model.read_device_model_atributes_from_database()
for device_model in device_models:
    print(device_model.model_name)
num=Device_model.count_device_models_from_database()
print(f"Broj device_modela u bazi podataka je: {num}")
print("_______________________________________________")

device_models[num-1].update_device_model({"water_capacity_liters":5})
device_models=Device_model.read_device_model_atributes_from_database()
print(device_models[num-1].water_capacity_liters)
