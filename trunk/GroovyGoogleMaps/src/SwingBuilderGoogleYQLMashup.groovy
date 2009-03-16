import groovy.swing.SwingBuilder
import org.jdesktop.swingx.JXMapKit
import org.jdesktop.swingx.mapviewer.Waypoint
import org.jdesktop.swingx.mapviewer.WaypointPainter
import static java.awt.BorderLayout.*
import static javax.swing.JFrame.EXIT_ON_CLOSE

class Attendee {
  String name
  String lastName
  String email
  String origin

  public String toString() {"Name:${name} Last name:${lastName} eMail:${email} origin:${origin}"}
}

def attendees = new ArrayList<Attendee>()

attendees << new Attendee(name: "Peter", lastName: "Pilgrim", email: "pp@example.com", origin: "IAD")
attendees << new Attendee(name: "Joel", lastName: "Neely", email: "jn@example.com", origin: "MEM")
attendees << new Attendee(name: "Dianne", lastName: "Marsh", email: "dm@example.com", origin: "DTW")
attendees << new Attendee(name: "Carl", lastName: "Quinn", email: "cq@example.com", origin: "SJC")
attendees << new Attendee(name: "Dick", lastName: "Wall", email: "dw@example.com", origin: "SJC")
attendees << new Attendee(name: "Joe", lastName: "Nuxoll", email: "jn@example.com", origin: "SJC")
attendees << new Attendee(name: "Bill", lastName: "Pugh", email: "pp@example.com", origin: "SJC")
attendees << new Attendee(name: "Dave", lastName: "Briccetti", email: "db@example.com", origin: "SFO")
attendees << new Attendee(name: "Todd", lastName: "Costella", email: "tc@example.com", origin: "YYC")
attendees << new Attendee(name: "StŒle", lastName: "Undheim", email: "su@example.com", origin: "FRA")
attendees << new Attendee(name: "Eirik", lastName: "Bj¿rsn¿s", email: "eb@example.com", origin: "MUC")
attendees << new Attendee(name: "Andrew", lastName: "Harmel-Law", email: "al@example.com", origin: "EDI")
attendees << new Attendee(name: "Oliver", lastName: "Gierke", email: "og@example.com", origin: "ORD")
attendees << new Attendee(name: "Joe", lastName: "Sondow", email: "js@example.com", origin: "LGA")
attendees << new Attendee(name: "Fred", lastName: "Simon", email: "fs@example.com", origin: "ORD")
attendees << new Attendee(name: "Daniel", lastName: "Watson", email: "dw@example.com", origin: "ATL")



def swing = SwingBuilder.build {
  frame(title: "Java Posse Roundup 2009", pack: true, show: true, defaultCloseOperation: EXIT_ON_CLOSE, id: "frame") {
    borderLayout()
    panel(constraints: NORTH) {
      boxLayout()
      button(text: "Refresh", actionPerformed: {
        doOutside {
          def waypoints = new HashSet<Waypoint>()
          attendees.each() {
            def url = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.places%20where%20text%3D%22${it.origin}%22&format=xml"
            status.text = "Looking up Airport: ${it.origin}"
            def doc = new XmlSlurper().parse(url)
            if (doc.results) {
              def latitude = doc.results.place[0].centroid.latitude.toString()
              def longitude = doc.results.place[0].centroid.longitude.toString()
              waypoints.add(new Waypoint(Double.valueOf(latitude), Double.valueOf(longitude)))
            }
          }
          WaypointPainter painter = new WaypointPainter()
          painter.setWaypoints(waypoints)
          map.getMainMap().setOverlayPainter(painter)
          status.text =""
        }
      })
      label(id:"status")
    }
    panel(constraints: CENTER) {
      borderLayout()
      scrollPane {
        table() {
          tableModel(list: attendees) {
            propertyColumn(header: 'Name', propertyName: 'name')
            propertyColumn(header: 'Last Name', propertyName: 'lastName')
            propertyColumn(header: 'EMail', propertyName: 'email')
            propertyColumn(header: 'Origin', propertyName: 'origin')
          }
        }
      }
    }
    panel(constraints: SOUTH) {
      borderLayout()
      scrollPane() {
        widget(new JXMapKit(), defaultProvider: JXMapKit.DefaultProviders.OpenStreetMaps, dataProviderCreditShown: true, id: "map")
      }
    }

  }
}

swing.doLater { frame.size = [800, 800] }
