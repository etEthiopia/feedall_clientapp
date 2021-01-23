class Client {
  String clientId;
  String name;
  String location;
  int unpaid;
  int paid;
  static Client client = Client();

  static setClient({clientId, name, location, paid, unpaid}) {
    client.clientId = clientId;
    client.name = name;
    client.location = location;
    client.paid = paid;
    client.unpaid = unpaid;
  }
}
