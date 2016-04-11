####### Framer Settings #######
Framer.Device.deviceType = "fullscreen"

####### Setup MQTT #######
mqtt = require("npm").mqtt
client = mqtt.connect
	host: "test.mosquitto.org"
	port: "8080"
	clientId: "framerJS_"+parseInt Math.random() * 100000

client.on 'connect', ->
	#print "client connected"
	client.subscribe 'framerJS/mqtt/state'
	client.publish 'framerJS/mqtt/init', 'Hello frameJS is connected'

client.on 'message', (topic, message) ->
	messageObject = JSON.parse(message)
	print "incomming Message: " + messageObject.state
	for layer in LayerObject
		if layer.name == messageObject.state
			print "- found "+ layer.name
			layer.states.switch("show")
		else
			layer.sendToBack()
			layer.states.switch("hide") 
	message

####### Layers #######

stateNames = ["red", "green", "blue"]
LayerObject = []

BaseLayer = new Layer
	x: 0
	y: 0
	width: Screen.width
	height: Screen.height
	borderRadius: 0
	backgroundColor: "#c9c9c9"
BaseLayer.sendToBack()
BaseLayer.center()

for stateName, i in stateNames
	LayerObject[i] = new Layer
		name: stateName
		#html: stateName
		x: 100
		y: 100
		width: 250
		height: 250
		opacity: 1
		color: stateName
		image: "images/"+stateName+".png"
		parent: BaseLayer
	LayerObject[i].center()
	LayerObject[i].style["backgroundColor"] = stateName
	LayerObject[i].on Events.Click, (event, layer) ->
		payload = state: layer.name
		client.publish 'framerJS/mqtt/event', JSON.stringify payload
		print "clicked " + layer.name
	LayerObject[i].states.add
		hide:
			opacity: 0.0
		show:
			opacity: 1.0
	LayerObject[i].states.animationOptions = 
		curve: "ease_in_out"
		time: 1
	LayerObject[i].states.switch("hide")

LayerObject[0].states.switch("show")
LayerObject[0].bringToFront()







