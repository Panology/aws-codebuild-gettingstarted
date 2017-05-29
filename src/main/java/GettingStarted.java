public class GettingStarted {
  private static String message = "Getting Started";

  public static void main(String[] args) {
    System.out.println("Create MessageUtil instance ...");
    MessageUtil messageUtil = new MessageUtil(message);
    System.out.println();

    System.out.println("Message:");
    messageUtil.printMessage();
    System.out.println();

    System.out.println("Saluation:");
    messageUtil.salutationMessage();
    System.out.println();
  }
}
