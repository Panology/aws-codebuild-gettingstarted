public class MessageUtil {
  private String message;

  public MessageUtil(String message) {
    this.message = message;
  }

  public void setMessage(String newMessage) {
    this.message = newMessage;
  }

  public String printMessage() {
    System.out.println(message);
    return message;
  }

  public String salutationMessage() {
    message = "Hi! " + message;
    System.out.println(message);
    return message;
  }

/*
  public static void main(String[] args) {
    setMessage("GettingStarted");
    System.out.println("Message: " + messageUtil.printMessage());
    System.out.println("Saluation: " + messageUtil.salutationMessage());
  }
*/
}
