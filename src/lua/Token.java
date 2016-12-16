package lua;

public class Token {
    
    int type;
    String val;
    
    public Token(int t, String v){
        type = t;
        val = v;
    }
    
    public Token(int t){
        type = t;
    }
}