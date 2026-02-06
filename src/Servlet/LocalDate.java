package Servlet;
import java.text.SimpleDateFormat;
import java.util.Date;
public class LocalDate {

   public static void main(String args[]) {
      
	   String pattern = "yyyy-MM-dd";
	   SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

	   String date = simpleDateFormat.format(new Date());
	   System.out.println(date);
   }
}