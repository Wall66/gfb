/*
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Copyright 2010 Guilherme Barros
*/


void pachube_out()
{
  Serial.print("Connecting to pachube... ");
  if (pachubeClient.connect()) {
    Serial.println("connected");
 
 //dtostrf(T6temp, 4, 1, buffer)
    sprintf(pachube_data, "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s", 
//    dtostrf(T1temp, 4, 1, buffer), dtostrf(T2temp, 4, 1, buffer), dtostrf(T3temp, 4, 1, buffer),
//    dtostrf(T4temp, 4, 1, buffer), dtostrf(T5temp, 4, 1, buffer), dtostrf(T6temp, 4, 1, buffer),
//    dtostrf(T7temp, 4, 1, buffer), dtostrf(T8temp, 4, 1, buffer), dtostrf(T9temp, 4, 1, buffer),    dtostrf(T10temp, 4, 1, buffer)
    T1tempS,T2tempS,T3tempS,T4tempS,T5tempS,T6tempS,T7tempS,T8tempS,T9tempS,T10tempS
    );

    Serial.print("sending: ");
    Serial.println(pachube_data);

    pachubeClient.print("PUT /api/");
    pachubeClient.print(PACHUBE_FEED_ID);
    pachubeClient.print(".csv HTTP/1.1\nHost: pachube.com\nX-PachubeApiKey: ");
    pachubeClient.print(PACHUBE_API_KEY);
    pachubeClient.print("\nUser-Agent: Arduino");
    pachubeClient.print("\nContent-Type: text/csv\nContent-Length: ");
    pachubeClient.print(strlen(pachube_data));
    pachubeClient.print("\nConnection: close\n\n");
    pachubeClient.print(pachube_data);
    pachubeClient.print("\n");

    //disconnecting
    delay(10); // play with this...
    Serial.println("disconnecting...\n");
    pachubeClient.stop();
  } 
  else {
    Serial.println("connection failed!\n");
    //pachube_out(); // retry?
  }
}
