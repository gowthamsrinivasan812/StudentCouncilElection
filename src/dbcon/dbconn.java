package dbcon;

import java.sql.Connection;
import java.sql.DriverManager;

public class dbconn {

    static Connection con;

    public static Connection create() {
        try {
          
            Class.forName("com.mysql.cj.jdbc.Driver");

           
            String url = "jdbc:mysql://stucentcouncilelection.cbw2oqgu8gg2.eu-north-1.rds.amazonaws.com:3306/studentvoute"
                       + "?useSSL=true&requireSSL=true&serverTimezone=UTC";

            String user = "admin";
            String password = "gowthamsrinivasan";

            con = DriverManager.getConnection(url, user, password);

            System.out.println("✅ AWS RDS Connected Successfully");

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return con;
    }
}
