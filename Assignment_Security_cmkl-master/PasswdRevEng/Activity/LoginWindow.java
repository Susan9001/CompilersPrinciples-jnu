import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

public class LoginWindow extends JFrame {
    private static final long serialVersionUID = 1L;
    static LoginWindow instance;
    
    JLabel usernameLabel = new JLabel("Username");
    JTextField usernameField = new JTextField();
    JPanel blankPanel1 = new JPanel();
    JPanel blankPanel2 = new JPanel();
    JLabel level1Label = new JLabel("Level 1");
    JPasswordField level1Field = new JPasswordField(8);
    JButton level1Button = new JButton("Verify 1");
    JCheckBox level1CheckBox = new JCheckBox();
    JLabel level2Label = new JLabel("Level 2");
    JPasswordField level2Field = new JPasswordField(8);
    JButton level2Button = new JButton("Verify 2");
    JCheckBox level2CheckBox = new JCheckBox();
    JLabel level3Label = new JLabel("Level 3");
    JPasswordField level3Field = new JPasswordField(8);
    JButton level3Button = new JButton("Verify 3");
    JCheckBox level3CheckBox = new JCheckBox();
    JLabel level4Label = new JLabel("Level 4");
    JPasswordField level4Field = new JPasswordField(8);
    JButton level4Button = new JButton("Verify 4");
    JCheckBox level4CheckBox = new JCheckBox();
    
    public LoginWindow(String windowName) {
        super(windowName);
        this.getContentPane().setLayout(new GridLayout(5,4));
        this.getContentPane().add(usernameLabel);
        this.getContentPane().add(usernameField);
        this.getContentPane().add(blankPanel1);
        this.getContentPane().add(blankPanel2);
        this.getContentPane().add(level1Label);
        this.getContentPane().add(level1Field);
        this.getContentPane().add(level1Button);
        this.getContentPane().add(level1CheckBox);
        this.getContentPane().add(level2Label);
        this.getContentPane().add(level2Field);
        this.getContentPane().add(level2Button);
        this.getContentPane().add(level2CheckBox);
        this.getContentPane().add(level3Label);
        this.getContentPane().add(level3Field);
        this.getContentPane().add(level3Button);
        this.getContentPane().add(level3CheckBox);
        this.getContentPane().add(level4Label);
        this.getContentPane().add(level4Field);
        this.getContentPane().add(level4Button);
        this.getContentPane().add(level4CheckBox);
        level1CheckBox.setEnabled(false);
        level2CheckBox.setEnabled(false);
        level3CheckBox.setEnabled(false);
        level4CheckBox.setEnabled(false);
        level1Button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                String username = usernameField.getText();
                String password = String.valueOf(level1Field.getPassword());
                boolean isCorrectPassword = Authentication.level1Authen(username, password);
                if (isCorrectPassword) {
                    level1CheckBox.setSelected(true);
                } else {
                    level1CheckBox.setSelected(false);
                }
            }
        });
        level2Button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                String username = usernameField.getText();
                String password = String.valueOf(level2Field.getPassword());
                boolean isCorrectPassword = Authentication.level2Authen(username, password);
                if (isCorrectPassword) {
                    level2CheckBox.setSelected(true);
                } else {
                    level2CheckBox.setSelected(false);
                }
            }
        });
        level3Button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                String username = usernameField.getText();
                String password = String.valueOf(level3Field.getPassword());
                boolean isCorrectPassword = Authentication.level3Authen(username, password);
                if (isCorrectPassword) {
                    level3CheckBox.setSelected(true);
                } else {
                    level3CheckBox.setSelected(false);
                }
            }
        });
        level4Button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                String username = usernameField.getText();
                String password = String.valueOf(level4Field.getPassword());
                boolean isCorrectPassword = Authentication.level4Authen(username, password);
                if (isCorrectPassword) {
                    level4CheckBox.setSelected(true);
                } else {
                    level4CheckBox.setSelected(false);
                }
            }
        });
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.pack();
    }
    
    public static void run() {
        instance = new LoginWindow("4-level Password");
        instance.setLocationRelativeTo(null);
        instance.setVisible(true);
    }
    
    public static void main(String args[]) {
        run();
    }
}
