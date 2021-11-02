import java.util.*;
import java.io.*;
public class challenge {
   public static void main(String[] args) throws FileNotFoundException {
      Scanner s = new Scanner(new BufferedReader(new FileReader("flag.txt")));
      String flag = s.nextLine();
      
      char[] r2 = flag.toCharArray();
      String build = "";
      for(int a = 0; a < r2.length; a++)
      {
         build += (char)(158 - r2[a]);
      }
      r2 = build.toCharArray();
      build = "";
      for(int a = 0; 2*a < r2.length - 1; a++)
      {
         build += (char)((2*r2[2*a]-r2[2*a+1]+153)%93+33);
         build += (char)((r2[2*a+1]-r2[2*a]+93)%93+33);
      }
      System.out.println(build);


      
      
   }
}