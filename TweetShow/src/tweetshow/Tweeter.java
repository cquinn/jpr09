package tweetshow;

import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.http.HttpClient;
import twitter4j.http.PostParameter;
import twitter4j.http.Response;

/**
 *
 * @author mattg
 */
public class Tweeter {

    private String twitterId = "";
    private String twitterPassword = "";

    public Twitter twitter;


    public Tweeter() {
        twitter = new Twitter(twitterId,twitterPassword);
    }

    public List<Status> getMyStatuses() {

        List<Status> statuses = null;
        try {
            statuses = twitter.getFriendsTimeline();
        } catch (TwitterException ex) {
            ex.printStackTrace();
        }

        return statuses;
    }

    @SuppressWarnings("deprecation")
    public List<Status> getMyLastStatuses(int minAgo) throws TwitterException {

    	Date fiveMinAgo = new Date();
    	fiveMinAgo.setMinutes(fiveMinAgo.getMinutes() - minAgo);

        List<Status> statuses = null;
        try {
            statuses = twitter.getFriendsTimeline(fiveMinAgo);
        } catch (TwitterException ex) {
            ex.printStackTrace();
        }

        return statuses;
    }

    public List<Status> getAllStatuses() {

        List<Status> statuses = null;
        try {
            statuses = twitter.getUserTimeline("jpr09");
        } catch (TwitterException ex) {
            ex.printStackTrace();
        }

        System.out.println("Done getting statuses");
        return statuses;
    }

    @SuppressWarnings("deprecation")
    public List<Status> getLastStatuses(int minAgo) {

    	Date fiveMinAgo = new Date();
    	fiveMinAgo.setMinutes(fiveMinAgo.getMinutes() - minAgo);
        List<Status> statuses = null;
        try {
            statuses = twitter.getUserTimeline("jpr09", fiveMinAgo);
        } catch (TwitterException ex) {
            Logger.getLogger(Tweeter.class.getName()).log(Level.SEVERE, null, ex);
        }

        return statuses;
    }

    public void sendUpdate(String update) {
        try {
            twitter.update(update);
        } catch (TwitterException ex) {
            Logger.getLogger(Tweeter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) throws TwitterException {

        Tweeter tweeter = new Tweeter();

        List<Status> statii = tweeter.getAllStatuses();
        
        for(Status stat : statii) {
            System.out.println(stat.getUser().getName() + " => " + stat.getText() + "\n");
        }

    
    }

}
