package lua;

import java.util.ArrayList;
import java.util.Arrays;

public class No {

    public Token sym;
    public String rotulo;
    public ArrayList<No> filhos = new ArrayList<>();

    public No(String r, No... f) {
        rotulo = r;
        if (f.length > 0) {
            filhos.addAll(Arrays.asList(f));
        }
    }

    public No(Token s) {
        sym = s;
    }

    @Override
    public String toString() {
        StringBuilder s = new StringBuilder();
        s.append("|--[");
        if (sym == null) {
            s.append(this.rotulo);
        } else {
            s.append(this.sym.type);
            if(this.sym.val!=null){
                s.append(", ").append(this.sym.val);
            }
        }
        s.append("]\n");
        for (No filho : this.filhos) {
            s.append(filho.toString(1));
        }
        return s.toString();
    }

    public String toString(int i) {
        StringBuilder s = new StringBuilder();
        for (int j = 0; j < i; j++) {
            s.append("   |");
        }
        s.append("--[");
        if (sym == null) {
            s.append(this.rotulo);
        } else {
            s.append(this.sym.type);
            if(this.sym.val!=null){
                s.append(", ").append(this.sym.val);
            }
        }
        s.append("]\n");
        for (No filho : this.filhos) {
            s.append(filho.toString(i + 1));
        }
        return s.toString();
    }
}