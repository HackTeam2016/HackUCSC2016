
/**
 * Write a description of class test here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class test
{
    public static void main(String [] args){
        int count =0;
        int n=0;
        int a= 24;
        int b =5;
        do{
            n= n+a;
            count++;
        }
        while(n%b !=0);
        System.out.println(count);
    }
}
