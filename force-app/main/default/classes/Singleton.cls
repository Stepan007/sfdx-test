public class Singleton {
    private static Singleton instance = null;
    private Integer correlationId = 0;
       
    private Singleton() {

    }

    public static Singleton getInstance() {
       if(instance == null){
          instance = new Singleton();
       }
       return instance;
    }
    
    public Integer updateAndGetCorrelationId(){
       correlationId++;
       return correlationId;
    }
}