
package Quinto;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validators {
    Pattern pattern;
    Matcher matcher;
    public boolean IdValidator(String id){
        pattern = Pattern.compile("[0-9]{10}");
        matcher = pattern.matcher(id);
        return matcher.matches();
    }
}
