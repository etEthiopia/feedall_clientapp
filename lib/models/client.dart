class Client {
  String clientId;
  String name;
  String location;
  int unpaid;
  int paid;
  int breakfast;
  int lunch;
  int dinner;
  static Client client = Client();

  static setClient({clientId, name, location, paid, unpaid}) {
    client.clientId = clientId;
    client.name = name;
    client.location = location;
    client.paid = paid;
    client.unpaid = unpaid;
  }
}
