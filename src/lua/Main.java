package lua;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java_cup.runtime.Symbol;

/**
 *
 * @author marcos
 */
public class Main {
    static ArrayList<String> codigo = new ArrayList<>();
    public static void main(String[] args){
//        geraLex();
//        testaLex();
//        geraParser();
        testaParser();
    }
    public static void geraLex(){
        String path = "/home/marcos/compiler/LuaCompiler/src/lua/lexer.flex";
        File f = new File(path);
        jflex.Main.generate(f);
    }

    private static void testaLex() {
        try {
            String testFile = "/home/marcos/compiler/LuaCompiler/src/lua/test.lua";
            Lexer lex = new Lexer(new FileReader(testFile));
            System.out.println("-------------------------------------");
            Symbol actual = lex.next_token();
            while (actual.sym > 0){ //EOF
                actual = lex.next_token();
            }
            System.out.println("-------------------------------------");
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static void geraParser(){
        try {
            //java -jar ../include/java-cup-11a.jar -parser Parser -symbols Sym -destdir ./lua/ ./lua/Parser.cup
            String[] cup = {"-expect", "6","-parser","Parser","-symbols","Sym","-destdir","/home/marcos/compiler/LuaCompiler/src/lua/", "/home/marcos/compiler/LuaCompiler/src/lua/Parser.cup"};
            java_cup.Main.main(cup);
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
       
    }

    private static void testaParser() {
        try {
            String testFile = "/home/marcos/compiler/LuaCompiler/src/lua/test.lua";
            //Lê o arquivo teste para uma lista de linhas para facilitar a recuperação em caso de erro
            FileReader reader = new FileReader(testFile);
            BufferedReader buff = new BufferedReader(reader);
            String line = buff.readLine();
            while (line != null) {
                codigo.add(line);
                line = buff.readLine();
            }
            buff.close();
            reader.close();

            Parser p = new Parser(new Lexer(new FileReader(testFile)));
            No result = (No)p.parse().value;
            System.out.println("Compilação Concluída com Sucesso");
            System.out.println("ARVORE");
            System.out.println(result);
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static void printErro(int line, int col){
        System.out.println("Erro sintático na linha " + (line+1) + " coluna " + col + ":");
        String s = codigo.get(line);
        System.out.println(s);
        
        //Loop para adicionar espaços para apontar a posição incorreta
        int i = 0;
        s = s.substring(col);
        for (; i < s.length(); i++) {
            if (s.charAt(i) == ' ' || s.charAt(i) == ';' || s.charAt(i) == '(' || s.charAt(i) == ')' || s.charAt(i) == ',') {
                break;
            }
        }
        for (int j = 0; j < col + i; j++) {
            System.out.print(" ");
        }
        System.out.println("↑");
        System.exit(-1);
    }
}
