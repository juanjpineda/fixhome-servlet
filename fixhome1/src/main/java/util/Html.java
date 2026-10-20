package util;

import java.text.Normalizer;

public class Html {

    // Evita que un dato guardado inyecte HTML en la página
    public static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }

    // Texto en minúsculas y sin tildes, para buscar sin importar acentos
    public static String norm(String s) {
        if (s == null) return "";
        return Normalizer.normalize(s, Normalizer.Form.NFD)
                .replaceAll("\\p{M}", "").toLowerCase();
    }
}