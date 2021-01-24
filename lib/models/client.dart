class Client {
  String clientId;
  String fid;
  String name;
  String location;
  int unpaid;
  int paid;
  int breakfast;
  int lunch;
  int dinner;
  static Client client = Client();

  static setClient({fid, clientId, name, location, paid, unpaid}) {
    client.fid = fid;
    client.clientId = clientId;
    client.name = name;
    client.location = location;
    client.paid = paid;
    client.unpaid = unpaid;
  }
}
