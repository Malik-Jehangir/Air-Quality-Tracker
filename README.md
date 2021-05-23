# Air-Quality-Tracker
ATrack is a smart handheld air health measuring gadget that uses the power of Azure cloud to measure the Particulate Matter (PM) in the air. It alerts the user of the incoming potential air quality related vulnerabilities to advice proper actions via a mobile app. The device is small so it can be attached using a hook to user’s pants, bag, wheelchair, as well as it can be attached to the back of a user’s phone to be used as an air quality tracker.
The gadget once powered on, can be connected via Bluetooth to a cross platform mobile application. The flutter based application retrieves the sensor readings of Ammonia, Carbon dioxide, carbon monoxide, total volatile organic compounds, and nitrogen dioxide to estimate the Particulate Matter (PM) and then analyses them using a machine learning algorithm to predict alerts and potential warnings. The user can save this report, use the cognitive service based chatbot service for further help.
All these services and resources are being monitored by Azure health monitor in the cloud to ensure the availability of the system and inform the developer in case of disruption that might occur due to any upcoming maintenance.
Note that ATrack consists with two modules, the ATrack module embedded with sensors and the cross platform mobile application. Note that it is a palm sized module that sends the data to a mobile application, and since it uses the power of Azure, it is capable to generate the results in real time.
It uses: 
Flutter SDK for cross platform app development
Arduino UNO 3
Heart Rate pulse sensor, CCS811 sensor module and MICS-6814 Gases sensor module
Azure Machine Learning Studio
Azure Storage
Azure Chat Bot
Azure Cognitive Services
Azure Health Monitoring
