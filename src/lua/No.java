package lua;

import java.util.ArrayList;
import java.util.Arrays;

public class No {

    public Token sym;
    public String name;
    public ArrayList<No> filhos = new ArrayList<>();

    public No(String r, No... f) {
        name = r;
        if (f.length > 0) {
            filhos.addAll(Arrays.asList(f));
        }
    }

    public No(Token s) {
        sym = s;
    }
}