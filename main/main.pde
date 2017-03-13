import websockets.*;

boolean newEllipse;
WebsocketClient wsc;
PVector remotePosition;
float now;

void setup(){
  size(20,20);
  
  newEllipse=false;
  
  wsc= new WebsocketClient(this, "ws://localhost:8080/ws/websocket");
  
  JSONObject message = new JSONObject();
  message.setString("type", "auth");
  message.setString("device", "ambiant");
  wsc.sendMessage(message.toString());
  
  JSONObject msg = new JSONObject();
  msg.setString("test", "ambiant");
  wsc.sendMessage(msg.toString());
  
  remotePosition = new PVector(0,0);
  now = millis();
}

void draw(){
  if(newEllipse){
    if(remotePosition != null)
      ellipse(remotePosition.x,remotePosition.y,10,10);
    newEllipse=false;
  }
}
void webSocketEvent(String msg){
  println(msg);
  
 JSONObject json = parseJSONObject(msg);
  if (json == null) {
    println("JSONObject could not be parsed");
  } else {
    String species = json.getString("species");
    println(species);
  }
}