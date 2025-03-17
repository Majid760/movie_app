class HallMovieModel {
  DateTime date;

  List<CinemaHallRoom> cinemaHallRooms;

  HallMovieModel({required this.date, required this.cinemaHallRooms});

  static HallMovieModel seed() {
    return HallMovieModel(
      date: DateTime.now(),
      cinemaHallRooms: [
        CinemaHallRoom(time: DateTime.now(), roomName: 'Cine tech + hall 1', prices: ['100', '200']),
        CinemaHallRoom(
            time: DateTime.now().add(Duration(hours: 1)),
            roomName: 'Cine tech + hall 2',
            prices: ['100', '600', '300']),
        CinemaHallRoom(
            time: DateTime.now().add(Duration(hours: 3)), roomName: 'Cine tech + hall 3', prices: ['1000', '2000']),
      ],
    );
  }
}

class CinemaHallRoom {
  DateTime time;
  String roomName;
  List<String> prices;

  CinemaHallRoom({required this.time, required this.roomName, required this.prices});
}
