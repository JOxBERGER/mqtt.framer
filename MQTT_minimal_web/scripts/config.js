// host
//mqtt_host = '127.0.0.1';
mqtt_host = 'test.mosquitto.org'
// port
//mqtt_port = 9000;
mqtt_port = 8080

mqtt_client_id = "WEB_CLIENT_" + parseInt(Math.random() * 100000);

mqtt_subscribe_topic = 'framerJS/mqtt/#';		// topic to subscribe to
mqtt_subscribe_qos = 0;

mqtt_publish_topic = 'framerJS/mqtt/state';		// topic to subscribe to
mqtt_publish_message = '222';
mqtt_publish_retained = false;
mqtt_publish_qos = 0;
useTLS = false;
username = null;
password = null;
// username = "jjolie";
// password = "aa";
cleansession = true;
