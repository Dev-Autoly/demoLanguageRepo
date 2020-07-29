


class Lanaguage{
  final int id;
  final String name;
  final String flag;
  final String lanaguageCode;

  Lanaguage(this.id, this.name, this.flag, this.lanaguageCode);

  static List<Lanaguage> get lanagugeList{
    return <Lanaguage>[
      Lanaguage(1,"English","🇬🇧","en"),
      Lanaguage(2,"عربى","🇦🇪","ar"),
      Lanaguage(3,"हिन्दी","🇮🇳","hi"),
      Lanaguage(4,"Francais","🇫🇷","fr"),
      Lanaguage(5,"فارسی","🇮🇷","fa"),
    ];
  }
}