import java.awt.*;
import java.awt.event.*;

public class {{class_name}} extends Frame {

    {{component_list}}

    public {{class_name}} () {
        setLayout({{layout}});
        setTitle({{title}});
        setSize({{size}});

        {{component_add}}
    }

    public static void main(String[] args) {
        {{class_name}} frame = new {{class_name}}();
        frame.setVisible(true);
    }
}